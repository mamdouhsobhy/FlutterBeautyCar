
import 'dart:async';
import 'package:beauty_car/authentication/data/request/send_verify_code_request.dart';
import 'package:beauty_car/authentication/data/response/forgetPassword/forget_password.dart';
import 'package:beauty_car/authentication/domain/usecase/forget_passsword_usecase.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../utils/Constants.dart';

class ForgetPasswordViewModel extends BaseViewModel implements ForgetPasswordViewModelInputs,ForgetPasswordViewModelOutputs{

  final StreamController _sendOtpStreamController = BehaviorSubject<ModelForgetPasswordResponseRemote>();

  final ForgetPassswordUseCase _forgetPassswordUseCase;

  ForgetPasswordViewModel(this._forgetPassswordUseCase);

  final sendOtpRequest = SendVerifyCodeRequest("","");

  //inputs
  @override
  void dispose() {
     super.dispose();
     _sendOtpStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get sendOtpData => _sendOtpStreamController.sink;

  var isSendOtpLoading = false;
  var isOutStateLoading = false;

  Future<void> forgetPassword() async {
    isSendOtpLoading = false;
    isOutStateLoading = true;
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _forgetPassswordUseCase.execute(await buildSendOtpFormData()))
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

  Future<FormData> buildSendOtpFormData() async {
    return FormData.fromMap({
      "type": UserTypes.owner,
      "phone":  sendOtpRequest.phone
    });
  }

  //outputs

  @override
  Stream<ModelForgetPasswordResponseRemote> get outputSendOtpData => _sendOtpStreamController.stream.map((data) => data);

  @override
  bool isShowError = false;


}

abstract class ForgetPasswordViewModelInputs{
  Sink get sendOtpData;
}

abstract class ForgetPasswordViewModelOutputs{
  Stream<ModelForgetPasswordResponseRemote> get outputSendOtpData;
}
