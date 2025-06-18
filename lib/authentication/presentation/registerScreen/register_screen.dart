import 'package:beauty_car/authentication/data/response/register/register.dart';
import 'package:beauty_car/authentication/presentation/registerScreen/viewmodel/register_viewmodel.dart';
import 'package:beauty_car/authentication/presentation/routeManager/routesManager.dart';
import 'package:beauty_car/authentication/presentation/sharedViews/auth_title_and_subtitle.dart';
import 'package:beauty_car/utils/Constants.dart';
import 'package:beauty_car/utils/function.dart';
import 'package:beauty_car/utils/toast_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../app/di/di.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../resources/colorManager.dart';
import '../../../../utils/loading_page.dart';
import '../../../resources/assetsManager.dart';
import '../../../resources/fontManager.dart';
import '../../../resources/stringManager.dart';
import '../../../resources/styleManager.dart';
import '../../../resources/valuesManager.dart';
import '../../../utils/shared_button.dart';
import '../../../utils/shared_checkbox.dart';
import '../../../utils/shared_text_field.dart';
import '../../../utils/shared_text_field_with_phone_code.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final RegisterViewModel _registerViewModel = instance<RegisterViewModel>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isTermsAccepted = false;

  _bind() {
    _registerViewModel.start();
    _countryCodeController.text = Constants.defaultCountryCode;
  }

  void _navigateToVerifyScreen(String phone) {
    if(_registerViewModel.isRegisterLoading == true) {
      _registerViewModel.isRegisterLoading = false;
      context.showSuccessToast(AppStrings.you_registered_successfully.tr());
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacementNamed(context, Routes.verifyCodeRoute,
            arguments: {'phone': phone, 'type': ComeFrom.register});
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
          body: SafeArea(
            child:
            StreamBuilder<FlowState>(
              stream: _registerViewModel.outputState,
              builder: (context, snapshot) {
                if (snapshot.data != null && _registerViewModel.isOutStateLoading) {
                  _handleRegisterStateChanged(snapshot.data!);
                }
                return _getRegisterScreenContent();
              },
            ),
          ),
        ));
  }

  Widget _getRegisterScreenContent() {
    return  StreamBuilder<ModelRegisterResponseRemote>(
      stream: _registerViewModel.outputRegisterData,
      builder: (context, snapshot) {
        if (snapshot.data != null && snapshot.data?.status == true) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final phone = snapshot.data?.data?.phone;
            if (phone != null && phone.isNotEmpty) {
              _navigateToVerifyScreen(phone);
            }
          });
        }
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
                    child: SvgPicture.asset(ImageAssets.registerIcon,
                        width: AppSize.s190, height: AppSize.s190),
                  ),
                  const SizedBox(height: AppSize.s15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                    child: AuthTitleAndSubTitle(title: AppStrings.create_Account.tr(), subTitle: AppStrings.welcomeMessage.tr(),isShowImage: true),
                  ),
                  const SizedBox(height: AppSize.s15),
                  MyTextField(
                      hint: AppStrings.enterUsername.tr(),
                      title: AppStrings.username.tr(),
                      suffixIcon: ImageAssets.userIcon,
                      obscureText: false,
                      inputType: TextInputType.text,
                      controller: _userNameController,
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return AppStrings.enterUsername.tr();
                        } else {
                          null;
                        }
                        return null;
                      },
                      takeValue: (value) {
                        _userNameController.text = value;
                        _registerViewModel.registerRequest.name = value;
                      }
                  ),
                  const SizedBox(height: AppSize.s16),
                  MyTextField(
                      hint: AppStrings.enterEmail.tr(),
                      title: AppStrings.email.tr(),
                      suffixIcon: ImageAssets.emailIcon,
                      obscureText: false,
                      inputType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return AppStrings.enterEmail.tr();
                        }else if(!isEmailValid(value)){
                          return AppStrings.enter_valid_email.tr();
                        } else {
                          null;
                        }
                        return null;
                      },
                      takeValue: (value) {
                        _emailController.text = value;
                        _registerViewModel.registerRequest.email = value;
                      }
                  ),
                  const SizedBox(height: AppSize.s16),
                  MyTextFieldWithPhoneCode(
                      hint: AppStrings.enter_phone_number.tr(),
                      title: AppStrings.phone_number.tr(),
                      readOnly: false,
                      takeValue: (value) {
                        _phoneController.text = value;
                        _registerViewModel.registerRequest.phone = "";
                        _registerViewModel.registerRequest.phone = value;
                        print("PhoneCodeNumber ${_phoneController.text}");
                      },
                      takeCountryCode: (code) {
                        _countryCodeController.text = "$code".replaceAll("+", "");
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.enter_phone_number.tr();
                        } else if (!isPhoneValid(_phoneController.text, "+${_countryCodeController.text}")) {
                          return AppStrings.enter_valid_phone.tr();
                        }
                        return null;
                      },
                      paddingHorizontal: AppPadding.p16,
                      controller: _phoneController
                  ),
                  const SizedBox(height: AppSize.s16),
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
                        _registerViewModel.registerRequest.password = value;
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
                        _registerViewModel.registerRequest.password_confirmation = value;
                      }
                  ),
                  const SizedBox(height: AppSize.s10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyCheckBox(
                          title: AppStrings.agree_terms_conditions.tr(),
                          initialValue: _isTermsAccepted,
                          onChanged: (value) {
                            _isTermsAccepted = value;
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSize.s50),
                  MyButton(
                    color: ColorManager.colorRedB2,
                    buttonText: AppStrings.create_Account.tr(),
                    paddingVertical: AppPadding.p0,
                    fun: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        if (!_isTermsAccepted) {
                          context.showErrorToast(AppStrings.agree_terms_conditions.tr());
                          return;
                        }
                        _registerViewModel.register();
                      }
                    },
                  ),
                  const SizedBox(height: AppSize.s20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.alreadyHaveAccount.tr(),
                        style:
                        getRegularStyle(color: ColorManager.black,fontSize: FontSize.size16),
                      ),
                      const Text(" "),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppStrings.sign_in.tr(),
                          style:
                          getRegularStyle(color: ColorManager.colorRedB2,fontSize: FontSize.size16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s60),
                ],
              )),
        );
      },
    );
  }

  _handleRegisterStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _registerViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        _registerViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
      } else {
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _registerViewModel.dispose();
    super.dispose();
  }
}
