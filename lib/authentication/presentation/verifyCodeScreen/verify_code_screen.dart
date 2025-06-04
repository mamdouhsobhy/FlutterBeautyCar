import 'package:beauty_car/authentication/presentation/sharedViews/auth_title_and_subtitle.dart';
import 'package:beauty_car/utils/toast_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
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
import '../routeManager/routesManager.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  String? _phoneNumber;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Don't access ModalRoute here
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      // Get phone number from route arguments
      final args = ModalRoute.of(context)?.settings.arguments;
      print("Verify Screen - didChangeDependencies - Received args: $args");
      
      if (args != null && args is String) {
        setState(() {
          _phoneNumber = args;
          _isInitialized = true;
          print("Verify Screen - didChangeDependencies - Set phone number to: $_phoneNumber");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Only check args in build if we haven't initialized yet
    if (!_isInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is String) {
        _phoneNumber = args;
        _isInitialized = true;
        print("Verify Screen - build - Set phone number to: $_phoneNumber");
      }
    }

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
            child: _getVerifyCodeScreenContent(),
          ),
        ));
  }

  Widget _getVerifyCodeScreenContent() {
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
              child: SvgPicture.asset(
                ImageAssets.forgetPasswordIcon,
                width: AppSize.s190,
                height: AppSize.s190
              ),
            ),
            const SizedBox(height: AppSize.s30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.enterVerificationCode.tr(),
                    style: getBoldStyle(
                      color: ColorManager.colorBlack33,
                      fontSize: FontSize.size16
                    )
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        AppStrings.verificationCodeSentTo.tr(),
                        style: getRegularStyle(
                          color: ColorManager.colorBlack03,
                          fontSize: FontSize.size12
                        ),
                      ),
                      const Text(" "),
                      Text(
                        _phoneNumber ?? "No phone number",
                        style: getRegularStyle(
                          color: ColorManager.colorRedB2,
                          fontSize: FontSize.size12
                        ),
                      )
                    ],
                  ),
                ],
              )
            ),
            const SizedBox(height: AppSize.s30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
              child: PinCodeTextField(
                appContext: context,
                length: 6,
                keyboardType: TextInputType.number,
                animationType: AnimationType.none,
                autoFocus: true,
                controller: _otpController,
                onChanged: (value) {},
                onCompleted: (value) {
                  // Handle OTP completion
                  print("OTP Completed: $value");
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.circle,
                  borderRadius: BorderRadius.circular(AppSize.s30),
                  fieldHeight: AppSize.s50,
                  fieldWidth: AppSize.s56,
                  activeColor: ColorManager.colorRedB5,
                  selectedColor: ColorManager.colorRedFA,
                  inactiveColor: ColorManager.colorGrayD9,
                  activeFillColor: ColorManager.colorRedFA,
                  inactiveFillColor: ColorManager.colorGrayD9,
                  selectedFillColor: ColorManager.colorGrayD9,
                  borderWidth: AppSize.s1_5
                ),
                textStyle: getMediumStyle(
                  color: ColorManager.colorBlack_0D,
                  fontSize: AppSize.s16
                ),
                enableActiveFill: true,
              ),
            ),
            const SizedBox(height: AppSize.s30),
            MyButton(
              color: ColorManager.colorRedB2,
              buttonText: AppStrings.confirm.tr(),
              paddingVertical: AppPadding.p0,
              fun: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // Handle verification
                  if (_otpController.text.length == 6) {
                    // TODO: Implement verification logic
                    Navigator.pushNamed(context, Routes.resetPasswordRoute);
                  } else {
                    context.showErrorToast("AppStrings.enterValidCode.tr()");
                  }
                }
              },
            ),
            const SizedBox(height: AppSize.s16),
            Align(
              alignment: Alignment.center,
              child: Text(
                "00:00",
                style: getRegularStyle(
                  color: ColorManager.colorRedB2,
                  fontSize: FontSize.size16
                )
              )
            ),
            const SizedBox(height: AppSize.s16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.didNotReceiveCode.tr(),
                  style: getRegularStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.size16
                  ),
                ),
                const Text(" "),
                InkWell(
                  onTap: () {
                    // TODO: Implement resend code logic
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppStrings.resendCode.tr(),
                    style: getRegularStyle(
                      color: ColorManager.colorRedB2,
                      fontSize: FontSize.size16
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s40),
          ],
        )
      ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}
