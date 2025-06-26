import 'dart:async';
import 'package:beauty_car/home/data/request/rated_orders_request.dart';
import 'package:beauty_car/home/data/response/getRatedOrders/get_rated_orders.dart';
import 'package:beauty_car/home/domain/usecase/rated_orders_usecase.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';

class ReviewOrdersViewModel extends BaseViewModel implements ReviewOrdersViewModelInputs,ReviewOrdersViewModelOutputs{

  final StreamController _ratedOrdersStreamController = BehaviorSubject<ModelGetRatedOrdersResponseRemote>();

  final RatedOrdersUseCase _ratedOrdersUseCase;

  final ratedOrderRequest = RatedOrdersRequest(true , 6 , "" , 1);

  int page = 1;
  List<Data> ratedOrdersList = [];

  ReviewOrdersViewModel(this._ratedOrdersUseCase);

  //inputs
  @override
  void dispose() {
     super.dispose();
     _ratedOrdersStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
    getRatedOrders();
  }

  @override
  void resetPage() {
    page = 1;
    ratedOrderRequest.page = 1;
    ratedOrdersList.clear();
  }

  @override
  Sink get ratedOrdersData => _ratedOrdersStreamController.sink;

   var isRatedOrdersLoading = false;
   var isOutStateLoading = false;

  Future<void> getRatedOrders() async {
    isRatedOrdersLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _ratedOrdersUseCase.execute(ratedOrderRequest))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isRatedOrdersLoading = true;
      ratedOrdersData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  //outputs
  @override
  Stream<ModelGetRatedOrdersResponseRemote> get outputRatedOrdersData => _ratedOrdersStreamController.stream.map((data) => data);

   @override
   bool isShowError = false;


}

abstract class ReviewOrdersViewModelInputs{
   Sink get ratedOrdersData;
   void resetPage();
}

abstract class ReviewOrdersViewModelOutputs{
  Stream<ModelGetRatedOrdersResponseRemote> get outputRatedOrdersData;
}
