
import 'dart:async';
import 'package:beauty_car/authentication/data/request/send_verify_code_request.dart';
import 'package:beauty_car/authentication/data/request/verify_account_request.dart';
import 'package:beauty_car/authentication/data/response/sendVerifyCode/send_verify_code.dart';
import 'package:beauty_car/authentication/data/response/verifyAccount/verify_account.dart';
import 'package:beauty_car/authentication/domain/usecase/verify_code_usecase.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../utils/Constants.dart';

class VerifyViewModel extends BaseViewModel implements VerifyViewModelInputs,VerifyViewModelOutputs{

  final StreamController _verifyStreamController = BehaviorSubject<ModelVerifyAccountResponseRemote>();
  final StreamController _sendOtpStreamController = BehaviorSubject<ModelSendVerifyCodeResponseRemote>();

  final VerifyCodeUseCase _verifyCodeUseCase;

  VerifyViewModel(this._verifyCodeUseCase);

  final verifyRequest = VerifyAccountRequest("","","");
  final sendOtpRequest = SendVerifyCodeRequest("","");

  //inputs
  @override
  void dispose() {
     super.dispose();
     _verifyStreamController.close();
     _sendOtpStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get verifyData => _verifyStreamController.sink;

  @override
  Sink get sendOtpData => _sendOtpStreamController.sink;


  var isVerifyLoading = false;
  var isSendOtpLoading = false;
  var isOutStateLoading = false;

  Future<void> verifyAccount() async {
    isVerifyLoading = false;
    isOutStateLoading = true;
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _verifyCodeUseCase.execute(await buildVerifyAccountFormData()))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
          }, (data) {
      isVerifyLoading = true;
      verifyData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  Future<void> sendOtp() async {
    isSendOtpLoading = false;
    isOutStateLoading = true;
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _verifyCodeUseCase.executeSendVerifyCode(await buildSendOtpFormData()))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isSendOtpLoading = true;
      sendOtpData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  Future<FormData> buildVerifyAccountFormData() async {
    return FormData.fromMap({
      "type": verifyRequest.type,
      "phone":  verifyRequest.phone,
      "otp": verifyRequest.otp,
    });
  }

  Future<FormData> buildSendOtpFormData() async {
    return FormData.fromMap({
      "type": verifyRequest.type,
      "phone":  verifyRequest.phone
    });
  }

  //outputs
  @override
  Stream<ModelVerifyAccountResponseRemote> get outputVerifyData => _verifyStreamController.stream.map((data) => data);

  @override
  Stream<ModelSendVerifyCodeResponseRemote> get outputSendOtpData => _sendOtpStreamController.stream.map((data) => data);

  @override
  bool isShowError = false;


}

abstract class VerifyViewModelInputs{
  Sink get verifyData;
  Sink get sendOtpData;
}

abstract class VerifyViewModelOutputs{
  Stream<ModelVerifyAccountResponseRemote> get outputVerifyData;
  Stream<ModelSendVerifyCodeResponseRemote> get outputSendOtpData;
}
