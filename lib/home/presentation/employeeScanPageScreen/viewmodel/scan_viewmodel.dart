
import 'dart:async';
import 'package:beauty_car/home/data/response/completeOrder/complete_order.dart';
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:beauty_car/home/domain/usecase/scan_usecase.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../data/request/home_order_request.dart';

class ScanViewModel extends BaseViewModel implements ScanViewModelInputs,ScanViewModelOutputs{

  final StreamController _ordersStreamController = BehaviorSubject<ModelOrdersResponseRemote>();
  final StreamController _completeOrderStreamController = BehaviorSubject<ModelCompleteOrderResponseRemote>();

  final ScanUseCase _scanUseCase;

  ScanViewModel(this._scanUseCase);

  final orderRequest = HomeOrderRequest(true , 6 , 1,2);

  int page = 1;
  List<Data> ordersList = [];

  //inputs
  @override
  void dispose() {
     super.dispose();
     _ordersStreamController.close();
     _completeOrderStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
    getRecentOrders();
  }

  @override
  void resetPage() {
    page = 1;
    orderRequest.page = 1;
    ordersList.clear();
  }

  @override
  Sink get ordersData => _ordersStreamController.sink;

  @override
  Sink get completeOrdersData => _completeOrderStreamController.sink;

  var isOrdersLoading = false;
  var isCompleteOrderLoading = false;
   var isOutStateLoading = false;

  Future<void> getRecentOrders() async {
    isOrdersLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _scanUseCase.execute(orderRequest)) // 10 is limit for recent orders in home
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

  Future<void> completeOrder(String orderId , String clientId , String planId) async {
    isCompleteOrderLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _scanUseCase.executeCompleteOrder(await buildCompleteOrderFormData(orderId,clientId,planId))) // 10 is limit for recent orders in home
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isCompleteOrderLoading = true;
      completeOrdersData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  Future<FormData> buildCompleteOrderFormData(String orderId , String clientId , String planId) async {
    final formData = FormData();
    formData.fields.addAll([
      MapEntry("order_id", orderId),
      MapEntry("client_id", clientId),
      MapEntry("plan_id", planId),
    ]);

    return formData;
  }

  //outputs
  @override
  Stream<ModelOrdersResponseRemote> get outputOrdersData => _ordersStreamController.stream.map((data) => data);

  @override
  Stream<ModelCompleteOrderResponseRemote> get outputCompleteOrderData => _completeOrderStreamController.stream.map((data) => data);

  @override
   bool isShowError = false;


}

abstract class ScanViewModelInputs{
   Sink get ordersData;
   Sink get completeOrdersData;
   void resetPage();
}

abstract class ScanViewModelOutputs{
  Stream<ModelOrdersResponseRemote> get outputOrdersData;
  Stream<ModelCompleteOrderResponseRemote> get outputCompleteOrderData;
}
