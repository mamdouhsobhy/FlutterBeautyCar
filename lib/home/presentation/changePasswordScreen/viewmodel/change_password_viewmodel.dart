
import 'dart:async';
import 'dart:io';
import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:beauty_car/home/domain/usecase/profile_usecase.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../authentication/data/response/login/login.dart';
import '../../../../utils/Constants.dart';

class ChangePasswordViewModel extends BaseViewModel implements ChangePasswordViewModelInputs,ChangePasswordViewModelOutputs{

  final StreamController _changePasswordStreamController = BehaviorSubject<BaseResponse>();

  final ProfileUseCase _profileUseCase;

  ChangePasswordViewModel(this._profileUseCase);

  //inputs
  @override
  void dispose() {
     super.dispose();
     _changePasswordStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get changePasswordData => _changePasswordStreamController.sink;

   var isUpdateLoading = false;
   var isOutStateLoading = false;

  Future<void> updatePassword(String oldPassword,String newPassword,String confirmPassword) async {
    isUpdateLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _profileUseCase.executeChangePassword(await buildChangePasswordFormData(oldPassword,newPassword,confirmPassword)))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isUpdateLoading = true;
      changePasswordData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  Future<FormData> buildChangePasswordFormData(String oldPassword,String newPassword,String confirmPassword) async {
    final formData = FormData();
    formData.fields.addAll([
      MapEntry("old_password", oldPassword),
      const MapEntry("type", UserTypes.owner),
      MapEntry("password", newPassword),
      MapEntry("password_confirmation", confirmPassword),
    ]);

    return formData;
  }

  //outputs
  @override
  Stream<BaseResponse> get outputChangePasswordData => _changePasswordStreamController.stream.map((data) => data);

   @override
   bool isShowError = false;


}

abstract class ChangePasswordViewModelInputs{
   Sink get changePasswordData;
}

abstract class ChangePasswordViewModelOutputs{
  Stream<BaseResponse> get outputChangePasswordData;
}
