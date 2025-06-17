
import 'dart:async';
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:beauty_car/home/domain/usecase/home_usecase.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';

class HomeViewModel extends BaseViewModel implements HomeViewModelInputs,HomeViewModelOutputs{

  final StreamController _ordersStreamController = BehaviorSubject<ModelOrdersResponseRemote>();

  final HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

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
  Sink get ordersData => _ordersStreamController.sink;

   var isOrdersLoading = false;
   var isOutStateLoading = false;

  Future<void> getRecentOrders() async {
    isOrdersLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _homeUseCase.execute(10)) // 10 is limit for recent orders in home
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

abstract class HomeViewModelInputs{
   Sink get ordersData;
}

abstract class HomeViewModelOutputs{
  Stream<ModelOrdersResponseRemote> get outputOrdersData;
}
