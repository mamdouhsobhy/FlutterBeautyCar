
import 'dart:async';

import 'package:beauty_car/authentication/data/response/sendVerifyCode/send_verify_code.dart';
import 'package:beauty_car/authentication/data/response/verifyAccount/verify_account.dart';
import 'package:beauty_car/authentication/presentation/verifyCodeScreen/viewmodel/verify_viewmodel.dart';
import 'package:beauty_car/utils/Constants.dart';
import 'package:beauty_car/utils/toast_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../app/di/di.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../resources/assetsManager.dart';
import '../../../../resources/colorManager.dart';
import '../../../../resources/fontManager.dart';
import '../../../../resources/stringManager.dart';
import '../../../../resources/styleManager.dart';
import '../../../../resources/valuesManager.dart';
import '../../../../utils/loading_page.dart';
import '../../../../utils/shared_button.dart';
import '../../../app/sharedPrefs/app_prefs.dart';
import '../../../utils/shared_appbar.dart';
import '../routeManager/routesManager.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {

  final AppPreferences _appPreferences = instance<AppPreferences>();
  final VerifyViewModel _verifyViewModel = instance<VerifyViewModel>();
  String? _phoneNumber;
  String? _type;
  String? _code;
  final TextEditingController _otpController = TextEditingController();

  int _remainingTime = 60;
  String _countdownTime = "00:00";
  Timer? _timer;

  void _startCountdown() {
    _timer?.cancel();
    _remainingTime = 60;
    _countdownTime = "00:00";
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
          _countdownTime = "${_remainingTime ~/ 60}:${(_remainingTime % 60).toString().padLeft(2, '0')}";
        });
      } else {
        timer.cancel();
      }
    });
  }

  _bind() {
    _verifyViewModel.verifyRequest.type = "${_appPreferences.getUserType()}";
    _verifyViewModel.start();
  }

  @override
  void initState() {
    print("bind data");
    _bind();
    _startCountdown();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map<String, dynamic>) {
        setState(() {
          _phoneNumber = args['phone'];
          _type = args['type'];
          _code = args['code'];
          _verifyViewModel.verifyRequest.phone = _phoneNumber!;
        });
      }
  }

  _navigateToResetPasswordScreen() {
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacementNamed(context, Routes.resetPasswordRoute, arguments: {'phone': _phoneNumber, 'otp': _verifyViewModel.verifyRequest.otp});
      });
  }

  _navigateToLogin(){
    context.showSuccessToast(AppStrings.accountActivatedSuccessfully.tr());
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
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
            child: StreamBuilder<FlowState>(
              stream: _verifyViewModel.outputState,
              builder: (mContext, snapshot) {
                if (snapshot.data != null && _verifyViewModel.isOutStateLoading) {
                    _handleVerifyAccountStateChanged(snapshot.data!,mContext);
                }
                return _getVerifyCodeScreenContent();
              },
            ),
          ),
        ));
  }

  Widget _getVerifyCodeScreenContent() {
    return StreamBuilder<ModelVerifyAccountResponseRemote>(
      stream: _verifyViewModel.outputVerifyData,
      builder: (context, snapshot) {
        if (snapshot.data != null && snapshot.data?.status == true) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if(_verifyViewModel.isVerifyLoading == true) {
              _verifyViewModel.isVerifyLoading = false;
              _navigateToLogin();
            }
          });
        }
        return SingleChildScrollView(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.enterVerificationCode.tr(),
                        style: getBoldStyle(
                            color: ColorManager.colorBlack33,
                            fontSize: FontSize.size16)),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          AppStrings.verificationCodeSentTo.tr(),
                          style: getRegularStyle(
                              color: ColorManager.colorBlack03,
                              fontSize: FontSize.size12),
                        ),
                        const Text(" "),
                        Text(
                          _phoneNumber ?? "",
                          style: getRegularStyle(
                              color: ColorManager.colorRedB2,
                              fontSize: FontSize.size12),
                        )
                      ],
                    ),
                  ],
                )),
            const SizedBox(height: AppSize.s30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
              child: PinCodeTextField(
                appContext: context,
                length: 5,
                keyboardType: TextInputType.number,
                animationType: AnimationType.none,
                autoFocus: false,
                controller: _otpController,
                onChanged: (value) {
                  _verifyViewModel.verifyRequest.otp = value;
                },
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
                    borderWidth: AppSize.s1_5),
                textStyle: getMediumStyle(
                    color: ColorManager.colorBlack_0D, fontSize: AppSize.s16),
                enableActiveFill: true,
              ),
            ),
            const SizedBox(height: AppSize.s30),
            MyButton(
              color: ColorManager.colorRedB2,
              buttonText: AppStrings.confirm.tr(),
              paddingVertical: AppPadding.p0,
              fun: () {
                  if (_otpController.text.length == 5) {
                    if(_type == ComeFrom.register) {
                      _verifyViewModel.verifyAccount();
                    }else{
                      if(_otpController.text == _code) {
                        _navigateToResetPasswordScreen();
                      }else{
                        context.showErrorToast(
                            AppStrings.enter_valid_code.tr());
                      }
                    }
                  } else {
                    context.showErrorToast(
                        AppStrings.enter_full_code_with_6_digits.tr());
                  }
              },
            ),
            const SizedBox(height: AppSize.s16),
            _remainingTime == 0 ? Align(
                alignment: Alignment.center,
                child: Text("00:00",
                    style: getRegularStyle(
                        color: ColorManager.colorRedB2,
                        fontSize: FontSize.size16))) : SizedBox(),
            const SizedBox(height: AppSize.s16),
            StreamBuilder<ModelSendVerifyCodeResponseRemote>(
              stream: _verifyViewModel.outputSendOtpData,
              builder: (context, snapshot) {
                if (snapshot.data != null && snapshot.data?.status == true) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_verifyViewModel.isSendOtpLoading == true) {
                      if (_type == ComeFrom.forgetPassword) {
                        _code = "${snapshot.data?.data?.otp}";
                      }
                      _startCountdown();
                      _verifyViewModel.isSendOtpLoading = false;
                      context.showSuccessToast(AppStrings.code_sent_success.tr());
                    }
                  });
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _remainingTime != 0 ? AppStrings.resend_code_after.tr() : AppStrings.didNotReceiveCode.tr(),
                      style: getRegularStyle(
                          color: ColorManager.black, fontSize: FontSize.size16),
                    ),
                    const Text(" "),
                    InkWell(
                      onTap: () {
                        if(_remainingTime == 0) {
                          _verifyViewModel.sendOtp();
                        }
                      },
                      child: Text(
                _remainingTime != 0 ? _countdownTime : AppStrings.resendCode.tr(),
                        style: getRegularStyle(
                            color: ColorManager.colorRedB2, fontSize: FontSize.size16),
                      ),
                    ),
                  ],
                );
              },
            ) ,
            const SizedBox(height: AppSize.s40),
          ],
        ));
      },);
  }

  _handleVerifyAccountStateChanged(FlowState state, BuildContext mContext) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _verifyViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        _verifyViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
      } else {
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _verifyViewModel.dispose();
    super.dispose();
  }
}
