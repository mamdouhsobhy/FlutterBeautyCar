
import 'dart:async';
import 'package:beauty_car/authentication/data/request/register_request.dart';
import 'package:beauty_car/authentication/data/response/register/register.dart';
import 'package:beauty_car/authentication/domain/usecase/register_usecase.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../utils/Constants.dart';

class RegisterViewModel extends BaseViewModel implements LoginViewModelInputs,LoginViewModelOutputs{

  final StreamController _dataStreamController = BehaviorSubject<ModelRegisterResponseRemote>();

  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  final registerRequest = RegisterRequest("","","","","","","");

  //inputs
  @override
  void dispose() {
     super.dispose();
     _dataStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get registerData => _dataStreamController.sink;


  var isRegisterLoading = false;
  var isOutStateLoading = false;

  Future<void> register() async {
    isRegisterLoading = false;
    isOutStateLoading = true;
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _registerUseCase.execute(await buildRegisterFormData()))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isRegisterLoading = true;
      registerData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  Future<FormData> buildRegisterFormData() async {
    return FormData.fromMap({
      "name": registerRequest.name,
      "email":  registerRequest.email,
      "phone":  registerRequest.phone.replaceAll("+", ""),
      // "image": registerRequest.image.isEmpty ? null : await MultipartFile.fromFile(registerRequest.image),
      "type": registerRequest.type,
      "password": registerRequest.password,
      "password_confirmation": registerRequest.password_confirmation
    });
  }

  //outputs
  @override
  Stream<ModelRegisterResponseRemote> get outputRegisterData => _dataStreamController.stream.map((data) => data);

  @override
  bool isShowError = false;


}

abstract class LoginViewModelInputs{
  Sink get registerData;
}

abstract class LoginViewModelOutputs{
  Stream<ModelRegisterResponseRemote> get outputRegisterData;
}
