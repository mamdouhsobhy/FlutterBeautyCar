import 'package:beauty_car/authentication/presentation/resetPasswordScreen/viewmodel/reset_password_viewmodel.dart';
import 'package:beauty_car/authentication/presentation/routeManager/routesManager.dart';
import 'package:beauty_car/authentication/presentation/sharedViews/auth_title_and_subtitle.dart';
import 'package:beauty_car/utils/toast_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../app/di/di.dart';
import '../../../../../app/sharedPrefs/app_prefs.dart';
import '../../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../../resources/assetsManager.dart';
import '../../../../../resources/colorManager.dart';
import '../../../../../resources/fontManager.dart';
import '../../../../../resources/stringManager.dart';
import '../../../../../resources/styleManager.dart';
import '../../../../../resources/valuesManager.dart';
import '../../../../../utils/loading_page.dart';
import '../../../../../utils/shared_button.dart';
import '../../../../../utils/shared_checkbox.dart';
import '../../../../../utils/shared_text_field.dart';
import '../../../../../utils/shared_text_field_with_phone_code.dart';
import '../../../../utils/shared_appbar.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final AppPreferences _appPreferences = instance<AppPreferences>();

  final ResetPasswordViewModel _resetPasswordViewModel = instance<ResetPasswordViewModel>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _phoneNumber;
  String? _otp;

  _bind() {
    _resetPasswordViewModel.start();
    _resetPasswordViewModel.resetPasswordRequest.type = "${_appPreferences.getUserType()}";

  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      setState(() {
        _phoneNumber = args['phone'];
        _otp = args['otp'];
        _resetPasswordViewModel.resetPasswordRequest.phone = _phoneNumber!;
        _resetPasswordViewModel.resetPasswordRequest.otp = _otp!;
      });
    }
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
                stream: _resetPasswordViewModel.outputState,
                builder: (mContext, snapshot) {
                  if (snapshot.data != null && _resetPasswordViewModel.isOutStateLoading) {
                    _handleResetPasswordStateChanged(snapshot.data!);
                  }
                  return _getResetPasswordScreenContent();
                },
              ),
              ),
        ));
  }

  Widget _getResetPasswordScreenContent() {
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
            child: AuthTitleAndSubTitle(title: AppStrings.new_password.tr(), subTitle: AppStrings.enter_new_password.tr()),
          ),
          const SizedBox(height: AppSize.s15),
          MyTextField(
              hint: AppStrings.enterPassword.tr(),
              title: AppStrings.password.tr(),
              suffixIcon: "",
              obscureText: true,
              inputType: TextInputType.visiblePassword,
              controller: _passwordController,
              validator: (value){
                if (value == null || value.isEmpty) {
                  return AppStrings.enterPassword.tr();
                } else if(_passwordController.text.length < 6){
                  return AppStrings.password_must_be_6_character.tr();
                } else {
                  null;
                }
                return null;
              },
              takeValue: (value) {
                _passwordController.text = value;
                _resetPasswordViewModel.resetPasswordRequest.password = value;
              }
          ),
          const SizedBox(height: AppSize.s16),
          MyTextField(
              hint: AppStrings.enterPassword.tr(),
              title: AppStrings.confirmPassword.tr(),
              suffixIcon: "",
              obscureText: true,
              inputType: TextInputType.visiblePassword,
              controller: _confirmPasswordController,
              validator: (value){
                if (value == null || value.isEmpty) {
                  return AppStrings.confirmPassword.tr();
                }else if(_confirmPasswordController.text.length < 6){
                  return AppStrings.password_must_be_6_character.tr();
                }else if(_confirmPasswordController.text != _passwordController.text){
                  return AppStrings.confirm_password_must_at_the_same_password.tr();
                } else {
                  null;
                }
                return null;
              },
              takeValue: (value) {
                _confirmPasswordController.text = value;
                _resetPasswordViewModel.resetPasswordRequest.password_confirmation = value;
              }
          ),
          const SizedBox(height: AppSize.s50),
          MyButton(
            color: ColorManager.colorRedB2,
            buttonText: AppStrings.reset_password.tr(),
            paddingVertical: AppPadding.p0,
            fun: () {
              if (_formKey.currentState?.validate() ?? false) {
                _resetPasswordViewModel.resetPassword();
              }
            },
          ),
          const SizedBox(height: AppSize.s40),
        ],
      )),
    );
  }

  _handleResetPasswordStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _resetPasswordViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        context.showSuccessToast(AppStrings.reset_password_done.tr());
        Navigator.pushNamed(context, Routes.loginRoute);
        _resetPasswordViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
      } else {
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _resetPasswordViewModel.dispose();
    super.dispose();
  }
}
