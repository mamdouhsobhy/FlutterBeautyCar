
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel implements LoginViewModelInputs,LoginViewModelOutputs{

  // final StreamController _dataStreamController = BehaviorSubject<ModelLoginResponseRemote>();
  //
  // var loginObject = LoginObject("", "","","","");
  //
  // final LoginUseCase _loginUseCase;
  //
  // LoginViewModel(this._loginUseCase);
  //
  // //inputs
  // @override
  // void dispose() {
  //    super.dispose();
  //    _dataStreamController.close();
  // }
  //
  // @override
  // void start() {
  //   inputState.add(ContentState());
  // }
  //
  // @override
  // Sink get loginData => _dataStreamController.sink;
  //
  // @override
  // setLoginData(String userName , String password) {
  //   loginObject = loginObject.copyWith(username: userName , password: password);
  //   login();
  // }
  //
  // var isLoginLoading = false;
  //
  // @override
  // Future<void> login() async {
  //   isLoginLoading = false;
  //
  //   inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
  //
  //   (await _loginUseCase.execute(LoginUseCaseInput(loginObject.username, loginObject.password,"1","CPH2239","")))
  //       .fold(
  //         (failure) {
  //       inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
  //     }, (data) {
  //     isLoginLoading = true;
  //     loginData.add(data);
  //     inputState.add(SuccessState(""));
  //   },
  //   );
  // }
  //
  // //outputs
  // @override
  // Stream<ModelLoginResponseRemote> get outputLoginData => _dataStreamController.stream.map((data) => data);
  //
  // @override
   bool isShowError = false;

  @override
  void start() {
    // TODO: implement start
  }

}

abstract class LoginViewModelInputs{
  // setLoginData(String userName , String password);
  //
  // login();
  //
  // Sink get loginData;
}

abstract class LoginViewModelOutputs{
  //Stream<ModelLoginResponseRemote> get outputLoginData;
}
