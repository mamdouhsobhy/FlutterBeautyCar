import 'package:beauty_car/authentication/data/response/login/login.dart';
import 'package:beauty_car/authentication/presentation/sharedViews/auth_title_and_subtitle.dart';
import 'package:beauty_car/utils/toast_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../app/di/di.dart';
import '../../../../app/sharedPrefs/app_prefs.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../home/home_screen.dart';
import '../../../../resources/assetsManager.dart';
import '../../../../resources/colorManager.dart';
import '../../../../resources/fontManager.dart';
import '../../../../resources/stringManager.dart';
import '../../../../resources/styleManager.dart';
import '../../../../resources/valuesManager.dart';
import '../../../../utils/Constants.dart';
import '../../../../utils/function.dart';
import '../../../../utils/loading_page.dart';
import '../../../../utils/shared_button.dart';
import '../../../../utils/shared_checkbox.dart';
import '../../../../utils/shared_text_field.dart';
import '../../../../utils/shared_text_field_with_phone_code.dart';
import '../../routeManager/routesManager.dart';
import '../viewmodel/login_viewmodel.dart';
import '../../../../app/dio/dio_factory.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginViewModel _loginViewModel = instance<LoginViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isTermsAccepted = false;

  _bind() {
    _loginViewModel.start();
    _loginViewModel.loginObject.type = "${_appPreferences.getUserType()}";
    _countryCodeController.text = Constants.defaultCountryCode;
  }

  _intentToHomeScreen(ModelLoginResponseRemote? data) async {
      _appPreferences.setUserLoggedIn(true);
     _appPreferences.setUserData(data ?? ModelLoginResponseRemote());
       Constants.token = "${data?.token}";
      
      // Update Dio instance with new token
      final dioFactory = instance<DioFactory>();
      await dioFactory.updateToken(Constants.token);
      
      initHomeModule();
      initCentersModule();
      initOrdersModule();
      initEmployeeModule();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: ColorManager.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            child: Scaffold(
              backgroundColor: ColorManager.white,
              body: SafeArea(
                child:
                StreamBuilder<FlowState>(
                  stream: _loginViewModel.outputState,
                  builder: (context, snapshot) {
                    if (snapshot.data != null && _loginViewModel.isOutStateLoading) {
                      _handleLoginStateChanged(snapshot.data!);
                    }
                    return _getLoginScreenContent();
                  },
                ),
              ),
            )));
  }

  Widget _getLoginScreenContent() {
    return  StreamBuilder<ModelLoginResponseRemote>(
        stream: _loginViewModel.outputLoginData,
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data?.status == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              if (_loginViewModel.isLoginLoading == true) {
                _loginViewModel.isLoginLoading = false;
                await _intentToHomeScreen(snapshot.data);
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
          const SizedBox(height: AppSize.s60),
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(ImageAssets.loginIcon,
                width: AppSize.s190, height: AppSize.s190),
          ),
          const SizedBox(height: AppSize.s15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: AuthTitleAndSubTitle(title: AppStrings.sign_in.tr(), subTitle: AppStrings.welcome_back.tr(),isShowImage: true),
          ),
          const SizedBox(height: AppSize.s15),
          MyTextFieldWithPhoneCode(
              hint: AppStrings.enter_phone_number.tr(),
              title: AppStrings.phone_number.tr(),
              readOnly: false,
              defaultCountryCode: getIsoCode(_countryCodeController.text) ?? "SA",
              takeValue: (value) {
                _phoneController.text = value;
                _loginViewModel.loginObject.phone = "";
                _loginViewModel.loginObject.phone = _countryCodeController.text + value;
              },
              takeCountryCode: (code) {
                _countryCodeController.text = code;
                _loginViewModel.loginObject.phone = "";
                _loginViewModel.loginObject.phone = code + _phoneController.text;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.enter_phone_number.tr();
                } else if (!isPhoneValid(_phoneController.text, _countryCodeController.text)) {
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
                _loginViewModel.loginObject.password = value;
              }
          ),
          const SizedBox(height: AppSize.s10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: MyCheckBox(
                    title: AppStrings.agree_terms_conditions.tr(),
                    initialValue: _isTermsAccepted,
                    onChanged: (value) {
                      setState(() {
                        _isTermsAccepted = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.forgetPasswordRoute);
                    },
                    child: Text(
                      AppStrings.forgot_password.tr(),
                      style: getRegularStyle(
                        color: ColorManager.colorRedB2,
                        fontSize: FontSize.size12
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSize.s50),
          MyButton(
            color: ColorManager.colorRedB2,
            buttonText: AppStrings.sign_in.tr(),
            paddingVertical: AppPadding.p0,
            fun: () {
              if (_formKey.currentState?.validate() ?? false) {
                if (!_isTermsAccepted) {
                  context.showErrorToast(AppStrings.agree_terms_conditions.tr());
                  return;
                }else{
                  _loginViewModel.login();
                }
                // Handle login
              }
            },
          ),
          const SizedBox(height: AppSize.s20),
          if ("${_appPreferences.getUserType()}" == UserTypes.owner) Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.noAccount.tr(),
                style:
               getRegularStyle(color: ColorManager.black,fontSize: FontSize.size16),
              ),
              const Text(" "),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.registerRoute);
                },
                child: Text(
                  AppStrings.create_Account.tr(),
                  style:
                  getRegularStyle(color: ColorManager.colorRedB2,fontSize: FontSize.size16),
                ),
                ),
            ],
          ) else SizedBox(),
          const SizedBox(height: AppSize.s60),
        ],
      )),
    );
        });
  }

  _handleLoginStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _loginViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        _loginViewModel.isOutStateLoading = false;
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
    _passwordController.dispose();
    _loginViewModel.dispose();
    super.dispose();
  }
}
