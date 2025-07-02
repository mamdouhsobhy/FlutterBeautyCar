import 'package:beauty_car/authentication/data/response/forgetPassword/forget_password.dart';
import 'package:beauty_car/authentication/data/response/sendVerifyCode/send_verify_code.dart';
import 'package:beauty_car/authentication/presentation/forgetPasswordScreen/viewmodel/forget_password_viewmodel.dart';
import 'package:beauty_car/authentication/presentation/routeManager/routesManager.dart';
import 'package:beauty_car/authentication/presentation/sharedViews/auth_title_and_subtitle.dart';
import 'package:beauty_car/utils/toast_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../app/di/di.dart';
import '../../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../../resources/assetsManager.dart';
import '../../../../../resources/colorManager.dart';
import '../../../../../resources/fontManager.dart';
import '../../../../../resources/stringManager.dart';
import '../../../../../resources/styleManager.dart';
import '../../../../../resources/valuesManager.dart';
import '../../../../../utils/loading_page.dart';
import '../../../../../utils/shared_button.dart';
import '../../../../../utils/shared_text_field_with_phone_code.dart';
import '../../../../app/sharedPrefs/app_prefs.dart';
import '../../../../utils/Constants.dart';
import '../../../../utils/function.dart';
import '../../../../utils/shared_appbar.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  final AppPreferences _appPreferences = instance<AppPreferences>();
  final ForgetPasswordViewModel _forgetPasswordViewModel = instance<ForgetPasswordViewModel>();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();

  _bind() {
    _forgetPasswordViewModel.start();
    _forgetPasswordViewModel.sendOtpRequest.type = "${_appPreferences.getUserType()}";
    _countryCodeController.text = Constants.defaultCountryCode;
  }

  _intentToResetPasswordScreen(String? code) {
      context.showSuccessToast(AppStrings.code_sent_success.tr());
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacementNamed(context, Routes.verifyCodeRoute,
            arguments:{'code':code,'phone': _forgetPasswordViewModel.sendOtpRequest.phone, 'type': ComeFrom.forgetPassword} );
      });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: ColorManager.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: MyAppBar(title: ''),
          ),
          body: SafeArea(
              child:
              StreamBuilder<FlowState>(
                stream: _forgetPasswordViewModel.outputState,
                builder: (mContext, snapshot) {
                  if (snapshot.data != null && _forgetPasswordViewModel.isOutStateLoading) {
                    _handleForgetPasswordStateChanged(snapshot.data!);
                  }
                  return _getLoginScreenContent();
                },
              ),
              ),
        ));
  }

  Widget _getLoginScreenContent() {
    return Form(
          autovalidateMode: AutovalidateMode.onUnfocus,
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: AppSize.s40),
              Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(ImageAssets.forgetPasswordIcon,
                    width: AppSize.s190, height: AppSize.s190),
              ),
              const SizedBox(height: AppSize.s30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                child: AuthTitleAndSubTitle(
                    title: AppStrings.reset_password.tr(),
                    subTitle: AppStrings.enter_phone_to_send_code.tr()),
              ),
              const SizedBox(height: AppSize.s15),
              MyTextFieldWithPhoneCode(
                  hint: AppStrings.enter_phone_number.tr(),
                  title: AppStrings.phone_number.tr(),
                  readOnly: false,
                  defaultCountryCode: getIsoCode(_countryCodeController.text) ?? "SA",
                  takeValue: (value) {
                    _phoneController.text = value;
                    _forgetPasswordViewModel.sendOtpRequest.phone = "";
                    _forgetPasswordViewModel.sendOtpRequest.phone = _countryCodeController.text + value;
                  },
                  takeCountryCode: (code) {
                    _countryCodeController.text = code;
                    _forgetPasswordViewModel.sendOtpRequest.phone = "";
                    _forgetPasswordViewModel.sendOtpRequest.phone = code + _phoneController.text;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.enter_phone_number.tr();
                    } else if (!isPhoneValid(
                        _phoneController.text,_countryCodeController.text)) {
                      return AppStrings.enter_valid_phone.tr();
                    }
                    return null;
                  },
                  paddingHorizontal: AppPadding.p16,
                  controller: _phoneController),
              const SizedBox(height: AppSize.s50),
              StreamBuilder<ModelForgetPasswordResponseRemote>(
                  stream: _forgetPasswordViewModel.outputSendOtpData,
                  builder: (context, snapshot) {
                    if (snapshot.data != null &&
                        snapshot.data?.status == true) {
                      WidgetsBinding.instance.addPostFrameCallback((_)  {
                        if (_forgetPasswordViewModel.isSendOtpLoading == true) {
                          _forgetPasswordViewModel.isSendOtpLoading = false;
                          _intentToResetPasswordScreen("${snapshot.data?.data?.otp.toString()}");
                        }
                      });
                    }
                    return MyButton(
                      color: ColorManager.colorRedB2,
                      buttonText: AppStrings.sendVerificationCode.tr(),
                      paddingVertical: AppPadding.p0,
                      fun: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _forgetPasswordViewModel.forgetPassword();
                        }
                      },
                    );
                  }),
              const SizedBox(height: AppSize.s20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.remember_password.tr(),
                    style: getRegularStyle(
                        color: ColorManager.black, fontSize: FontSize.size16),
                  ),
                  const Text(" "),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppStrings.sign_in.tr(),
                      style: getRegularStyle(
                          color: ColorManager.colorRedB2,
                          fontSize: FontSize.size16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s190),
            ],
          )),
        );
  }

  _handleForgetPasswordStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _forgetPasswordViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        _forgetPasswordViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
      } else {
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _countryCodeController.dispose();
    _forgetPasswordViewModel.dispose();
    super.dispose();
  }

}
