
import 'dart:async';
import 'package:beauty_car/home/data/request/home_order_request.dart';
import 'package:beauty_car/home/data/response/getHomeStatistics/get_home_statistics.dart';
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:beauty_car/home/domain/usecase/home_usecase.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../authentication/data/response/login/login.dart';

class HomeViewModel extends BaseViewModel implements HomeViewModelInputs,HomeViewModelOutputs{

  final StreamController _ordersStreamController = BehaviorSubject<ModelOrdersResponseRemote>();
  final StreamController _homeStatisticsStreamController = BehaviorSubject<ModelGetHomeStatisticsResponseRemote>();
  final StreamController _updateNotifyDataStreamController = BehaviorSubject<ModelLoginResponseRemote>();

  final HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);


  //inputs
  @override
  void dispose() {
     super.dispose();
     _ordersStreamController.close();
     _homeStatisticsStreamController.close();
     _updateNotifyDataStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
    getRecentOrders();
    getStatistics();
  }

  @override
  Sink get ordersData => _ordersStreamController.sink;

  @override
  Sink get statisticsData => _homeStatisticsStreamController.sink;

  @override
  Sink get updateNotifyData => _updateNotifyDataStreamController.sink;

  var isOrdersLoading = false;
   var isStatisticsLoading = false;
   var isOutStateLoading = false;
  var isUpdateLoading = false;

  Future<void> getRecentOrders() async {
    isOrdersLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _homeUseCase.execute(HomeOrderRequest(true, 10 , 0 , 3))) // 10 is limit for recent orders in home
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isOrdersLoading = true;
      ordersData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  Future<void> getStatistics() async {
    isStatisticsLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _homeUseCase.executeHomeStatistics()) // 10 is limit for recent orders in home
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isStatisticsLoading = true;
      statisticsData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  Future<void> updateNotify(String fcmToken , String type) async {
    isUpdateLoading = false;
    isOutStateLoading = true;

    // inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _homeUseCase.executeUpdateNotification( await buildUpdateNotifyFormData(fcmToken,type) ))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isUpdateLoading = true;
      updateNotifyData.add(data);
      // inputState.add(SuccessState(""));
    },
    );
  }

  Future<FormData> buildUpdateNotifyFormData(String fcmToken , String type) async {
    return FormData.fromMap({
      "type": type,
      "fcm_token": fcmToken
    });
  }

  //outputs
  @override
  Stream<ModelOrdersResponseRemote> get outputOrdersData => _ordersStreamController.stream.map((data) => data);

  @override
  Stream<ModelGetHomeStatisticsResponseRemote> get outputStatisticsData => _homeStatisticsStreamController.stream.map((data) => data);

  @override
  Stream<ModelLoginResponseRemote> get outputUpdateNotifyData => _updateNotifyDataStreamController.stream.map((data) => data);

  @override
   bool isShowError = false;


}

abstract class HomeViewModelInputs{
   Sink get ordersData;
   Sink get statisticsData;
   Sink get updateNotifyData;
}

abstract class HomeViewModelOutputs{
  Stream<ModelOrdersResponseRemote> get outputOrdersData;
  Stream<ModelGetHomeStatisticsResponseRemote> get outputStatisticsData;
  Stream<ModelLoginResponseRemote> get outputUpdateNotifyData;
}
