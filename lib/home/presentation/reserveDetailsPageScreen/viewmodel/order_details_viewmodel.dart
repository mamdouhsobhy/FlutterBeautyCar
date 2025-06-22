import 'dart:async';
import 'package:beauty_car/home/data/request/order_details_request.dart';
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:beauty_car/home/domain/usecase/order_details_usecase.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';

class OrderDetailsViewModel extends BaseViewModel implements OrderDetailsViewModelInputs,OrderDetailsViewModelOutputs{

  final StreamController _orderStreamController = BehaviorSubject<ModelOrdersResponseRemote>();

  final OrderDetailsUseCase _orderDetailsUseCase;

  OrderDetailsViewModel(this._orderDetailsUseCase);

  bool isCenterFirstLoad = false;

  //inputs
  @override
  void dispose() {
     super.dispose();
     _orderStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get orderData => _orderStreamController.sink;

  var isOrderLoading = false;
   var isOutStateLoading = false;

  Future<void> getOrderDetails(String id) async {
    isOrderLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _orderDetailsUseCase.execute(OrderDetailsRequest(id)))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isOrderLoading = true;
      orderData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  //outputs
  @override
  Stream<ModelOrdersResponseRemote> get outputOrderData => _orderStreamController.stream.map((data) => data);

  @override
   bool isShowError = false;


}

abstract class OrderDetailsViewModelInputs{
   Sink get orderData;
}

abstract class OrderDetailsViewModelOutputs{
  Stream<ModelOrdersResponseRemote> get outputOrderData;
}
