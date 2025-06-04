import 'package:beauty_car/authentication/presentation/routeManager/routesManager.dart';
import 'package:beauty_car/authentication/presentation/sharedViews/auth_title_and_subtitle.dart';
import 'package:beauty_car/utils/toast_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../app/di/di.dart';
import '../../../../app/sharedPrefs/app_prefs.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
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
import '../../../utils/shared_appbar.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  //final LoginViewModel _loginViewModel = instance<LoginViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isTermsAccepted = false;

  _bind() {
    //_loginViewModel.start();
  }

  // _intentToHomeScreen(ModelLoginResponseRemote? data) {
  //   _appPreferences.setUserLoggedIn();
  //   _appPreferences.setUserData(data ?? ModelLoginResponseRemote());
  //   initAttendenceModule();
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => const HomeScreen()),
  //   );
  // }

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
        ));
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
          const SizedBox(height: AppSize.s40),
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(ImageAssets.forgetPasswordIcon,
                width: AppSize.s190, height: AppSize.s190),
          ),
          const SizedBox(height: AppSize.s30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: AuthTitleAndSubTitle(title: AppStrings.newPassword.tr(), subTitle: AppStrings.enterNewPassword.tr()),
          ),
          const SizedBox(height: AppSize.s15),
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
          const SizedBox(height: AppSize.s16),
          MyTextField(
              hint: AppStrings.enterPassword.tr(),
              title: AppStrings.confirmPassword.tr(),
              suffixIcon: "",
              obscureText: true,
              inputType: TextInputType.visiblePassword,
              controller: _passwordController,
              validator: null,
              takeValue: (value) {}
          ),
          const SizedBox(height: AppSize.s50),
          MyButton(
            color: ColorManager.colorRedB2,
            buttonText: AppStrings.reset_password.tr(),
            paddingVertical: AppPadding.p0,
            fun: () {
              Navigator.pushNamed(context, Routes.loginRoute);
              // if (_formKey.currentState?.validate() ?? false) {
              //   Navigator.pushNamed(context, Routes.verifyCodeRoute);
              // }
            },
          ),
          const SizedBox(height: AppSize.s40),
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
