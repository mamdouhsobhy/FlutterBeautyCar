import 'dart:async';
import 'package:beauty_car/home/data/request/orders_request.dart';
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:beauty_car/home/data/response/updateOrderStatus/update_order_status.dart';
import 'package:beauty_car/home/domain/usecase/orders_usecase.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';

class OrdersViewModel extends BaseViewModel implements OrdersViewModelInputs,OrdersViewModelOutputs{

  final StreamController _ordersStreamController = BehaviorSubject<ModelOrdersResponseRemote>();
  final StreamController _updateOrderStatusStreamController = BehaviorSubject<ModelUpdateOrderStatusResponseRemote>();

  final OrdersUseCase _ordersUseCase;

  final orderRequest = OrdersRequest(true , 6 , 1,1);

  int page = 1;
  List<Data> ordersList = [];

  OrdersViewModel(this._ordersUseCase);

  //inputs
  @override
  void dispose() {
     super.dispose();
     _ordersStreamController.close();
     _updateOrderStatusStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
    getOrders();
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
  Sink get updateOrderStatusData => _updateOrderStatusStreamController.sink;

  var isOrdersLoading = false;
  var isUpdateOrderLoading = false;
   var isOutStateLoading = false;

  Future<void> getOrders() async {
    isOrdersLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _ordersUseCase.execute(orderRequest))
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

  Future<void> updateOrderStatus(String orderId , int status) async {
    isUpdateOrderLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _ordersUseCase.executeUpdateOrderStatus(orderId,status))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isUpdateOrderLoading = true;
      updateOrderStatusData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  //outputs
  @override
  Stream<ModelOrdersResponseRemote> get outputOrdersData => _ordersStreamController.stream.map((data) => data);

  @override
  Stream<ModelUpdateOrderStatusResponseRemote> get outputUpdateOrderStatusData => _updateOrderStatusStreamController.stream.map((data) => data);

  @override
   bool isShowError = false;


}

abstract class OrdersViewModelInputs{
   Sink get ordersData;
   Sink get updateOrderStatusData;
   void resetPage();
}

abstract class OrdersViewModelOutputs{
  Stream<ModelOrdersResponseRemote> get outputOrdersData;
  Stream<ModelUpdateOrderStatusResponseRemote> get outputUpdateOrderStatusData;
}
