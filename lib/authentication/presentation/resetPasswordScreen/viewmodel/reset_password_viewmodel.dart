
import 'dart:async';
import 'package:beauty_car/authentication/data/request/reset_password_request.dart';
import 'package:beauty_car/authentication/data/response/resetPassword/reset_password.dart';
import 'package:beauty_car/authentication/domain/usecase/reset_passsword_usecase.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../utils/Constants.dart';

class ResetPasswordViewModel extends BaseViewModel implements ResetPasswordViewModelInputs,ResetPasswordViewModelOutputs{

  final StreamController _resetPasswordStreamController = BehaviorSubject<ModelResetPasswordResponseRemote>();

  final ResetPassswordUseCase _resetPassswordUseCase;

  ResetPasswordViewModel(this._resetPassswordUseCase);

  final resetPasswordRequest = ResetPasswordRequest("","","","","");

  //inputs
  @override
  void dispose() {
     super.dispose();
     _resetPasswordStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }


  @override
  Sink get resetPasswordData => _resetPasswordStreamController.sink;


  var isResetPasswordLoading = false;
  var isOutStateLoading = false;

  Future<void> resetPassword() async {
    isResetPasswordLoading = false;
    isOutStateLoading = true;
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _resetPassswordUseCase.execute(await buildResetPasswordFormData()))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isResetPasswordLoading = true;
      resetPasswordData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  Future<FormData> buildResetPasswordFormData() async {
    return FormData.fromMap({
      "type": resetPasswordRequest.type,
      "phone":  resetPasswordRequest.phone,
      "otp": resetPasswordRequest.otp,
      "password": resetPasswordRequest.password,
      "password_confirmation": resetPasswordRequest.password_confirmation,
    });
  }

  //outputs
  @override
  Stream<ModelResetPasswordResponseRemote> get outputResetPasswordData => _resetPasswordStreamController.stream.map((data) => data);

  @override
  bool isShowError = false;


}

abstract class ResetPasswordViewModelInputs{
  Sink get resetPasswordData;
}

abstract class ResetPasswordViewModelOutputs{
  Stream<ModelResetPasswordResponseRemote> get outputResetPasswordData;
}
