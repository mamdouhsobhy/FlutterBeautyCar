
import 'dart:async';
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:beauty_car/home/domain/usecase/scan_usecase.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../data/request/home_order_request.dart';
import '../../../data/request/orders_request.dart';

class ScanViewModel extends BaseViewModel implements ScanViewModelInputs,ScanViewModelOutputs{

  final StreamController _ordersStreamController = BehaviorSubject<ModelOrdersResponseRemote>();

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

   var isOrdersLoading = false;
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

  //outputs
  @override
  Stream<ModelOrdersResponseRemote> get outputOrdersData => _ordersStreamController.stream.map((data) => data);

   @override
   bool isShowError = false;


}

abstract class ScanViewModelInputs{
   Sink get ordersData;
   void resetPage();
}

abstract class ScanViewModelOutputs{
  Stream<ModelOrdersResponseRemote> get outputOrdersData;
}
