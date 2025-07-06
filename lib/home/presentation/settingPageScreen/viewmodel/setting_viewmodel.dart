import 'dart:async';
import 'package:beauty_car/authentication/data/response/login/login.dart';
import 'package:beauty_car/home/data/request/orders_request.dart';
import 'package:beauty_car/home/data/response/getSettings/get_settings.dart';
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:beauty_car/home/data/response/updateOrderStatus/update_order_status.dart';
import 'package:beauty_car/home/domain/usecase/orders_usecase.dart';
import 'package:beauty_car/home/domain/usecase/settings_usecase.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';

class SettingViewModel extends BaseViewModel implements SettingViewModelInputs,SettingViewModelOutputs{

  final StreamController _updateNotifyDataStreamController = BehaviorSubject<ModelLoginResponseRemote>();

  final SettingsUseCase _settingsUseCase;

  SettingViewModel(this._settingsUseCase);

  String type = "";

  //inputs
  @override
  void dispose() {
     super.dispose();
     _updateNotifyDataStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }


  @override
  Sink get updateNotifyData => _updateNotifyDataStreamController.sink;

  var isUpdateLoading = false;
  var isOutStateLoading = false;

  Future<void> updateNotify() async {
    isUpdateLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _settingsUseCase.executeUpdateNotification( await buildUpdateNotifyFormData() ))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isUpdateLoading = true;
      updateNotifyData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  Future<FormData> buildUpdateNotifyFormData() async {
    return FormData.fromMap({
      "type": type,
      // "fcm_Token": ""
    });
  }

  //outputs
  @override
  Stream<ModelLoginResponseRemote> get outputUpdateNotifyData => _updateNotifyDataStreamController.stream.map((data) => data);

  @override
   bool isShowError = false;


}

abstract class SettingViewModelInputs{
   Sink get updateNotifyData;
}

abstract class SettingViewModelOutputs{
  Stream<ModelLoginResponseRemote> get outputUpdateNotifyData;
}
