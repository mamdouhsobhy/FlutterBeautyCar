
import 'dart:async';
import 'dart:io';
import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:beauty_car/home/domain/usecase/delete_account_usecase.dart';
import 'package:beauty_car/home/domain/usecase/profile_usecase.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../authentication/data/response/login/login.dart';
import '../../../../utils/Constants.dart';

class DeleteAccountViewModel extends BaseViewModel implements DeleteAccountViewModelInputs,DeleteAccountViewModelOutputs{

  final StreamController _deleteAccountStreamController = BehaviorSubject<ModelLoginResponseRemote>();

  final DeleteAccountUseCase _deleteAccountUseCase;

  DeleteAccountViewModel(this._deleteAccountUseCase);

  //inputs
  @override
  void dispose() {
     super.dispose();
     _deleteAccountStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get deleteAccountData => _deleteAccountStreamController.sink;

   var isDeleteAccountLoading = false;
   var isOutStateLoading = false;

  Future<void> deleteAccount(String password,String type) async {
    isDeleteAccountLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _deleteAccountUseCase.execute(await buildDeleteAccountFormData(password,type)))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isDeleteAccountLoading = true;
      deleteAccountData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  Future<FormData> buildDeleteAccountFormData(String password,String type) async {
    final formData = FormData();
    formData.fields.addAll([
      MapEntry("type", type),
      MapEntry("password", password),
    ]);

    return formData;
  }

  //outputs
  @override
  Stream<ModelLoginResponseRemote> get outputDeleteAccountData => _deleteAccountStreamController.stream.map((data) => data);

   @override
   bool isShowError = false;


}

abstract class DeleteAccountViewModelInputs{
   Sink get deleteAccountData;
}

abstract class DeleteAccountViewModelOutputs{
  Stream<ModelLoginResponseRemote> get outputDeleteAccountData;
}
