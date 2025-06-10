
import 'dart:async';
import 'package:beauty_car/authentication/data/request/login_request.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../utils/Constants.dart';
import '../../../data/response/login/login.dart';
import '../../../domain/usecase/login_usecase.dart';

class LoginViewModel extends BaseViewModel implements LoginViewModelInputs,LoginViewModelOutputs{

  final StreamController _dataStreamController = BehaviorSubject<ModelLoginResponseRemote>();

  var loginObject = LoginRequest("", "","");

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

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
  Sink get loginData => _dataStreamController.sink;

   var isLoginLoading = false;
   var isOutStateLoading = false;

  Future<void> login() async {
    isLoginLoading = false;
    isOutStateLoading = false;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _loginUseCase.execute(await buildLoginFormData()))
        .fold(
          (failure) {
         isOutStateLoading = true;
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isOutStateLoading = true;
      isLoginLoading = true;
      loginData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  Future<FormData> buildLoginFormData() async {
    return FormData.fromMap({
      "phone":  loginObject.phone,
      "type": UserTypes.owner,
      "password": loginObject.password,
    });
  }

  //outputs
  @override
  Stream<ModelLoginResponseRemote> get outputLoginData => _dataStreamController.stream.map((data) => data);

   @override
   bool isShowError = false;


}

abstract class LoginViewModelInputs{
   Sink get loginData;
}

abstract class LoginViewModelOutputs{
  Stream<ModelLoginResponseRemote> get outputLoginData;
}
