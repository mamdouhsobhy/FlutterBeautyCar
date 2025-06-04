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
import '../../../../utils/loading_page.dart';
import '../../../../utils/shared_button.dart';
import '../../../../utils/shared_checkbox.dart';
import '../../../../utils/shared_text_field.dart';
import '../../../../utils/shared_text_field_with_phone_code.dart';
import '../../routeManager/routesManager.dart';
import '../viewmodel/login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //final LoginViewModel _loginViewModel = instance<LoginViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isTermsAccepted = false;

  _bind() {
    //_loginViewModel.start();
  }

  _intentToHomeScreen() {
    // _appPreferences.setUserLoggedIn();
    // _appPreferences.setUserData(data ?? ModelLoginResponseRemote());
    // initAttendenceModule();
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
                      // StreamBuilder<FlowState>(
                      //   stream: _loginViewModel.outputState,
                      //   builder: (context, snapshot) {
                      //     if (snapshot.data != null) {
                      //       _handleLoginStateChanged(snapshot.data!);
                      //     }
                      _getLoginScreenContent()
                  // },
                  // ),
                  ),
            )));
  }

  Widget _getLoginScreenContent() {
    final _formKey = GlobalKey<FormState>();
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
              takeValue: (value) {},
              takeCountryCode: (code) {

              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "AppStrings.select_currency.tr()";
                } else {
                  null;
                }
                return null;
              },
              paddingHorizontal: AppPadding.p16,
              controller: _passwordController
          ),
          const SizedBox(height: AppSize.s16),
          MyTextField(
              hint: AppStrings.enterPassword.tr(),
              title: AppStrings.password.tr(),
              suffixIcon: "",
              obscureText: true,
              inputType: TextInputType.visiblePassword,
              controller: _passwordController,
              validator: null,
              takeValue: (value) {}
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
              _intentToHomeScreen();
              // if (_formKey.currentState?.validate() ?? false) {
              //   if (!_isTermsAccepted) {
              //     //context.showErrorToast(AppStrings.please_accept_terms.tr());
              //     return;
              //   }
              //   // Handle login
              // }
            },
          ),
          const SizedBox(height: AppSize.s20),
          Row(
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
          ),
          const SizedBox(height: AppSize.s60),
        ],
      )),
    );
  }

  _handleLoginStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        dismissLoadingDialog();
        context.showSuccessToast("Logged In Successfully");
      } else {
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    //_loginViewModel.dispose();
    super.dispose();
  }
}
