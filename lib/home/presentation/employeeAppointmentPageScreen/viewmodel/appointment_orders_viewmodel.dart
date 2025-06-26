import 'dart:async';
import 'package:beauty_car/home/data/request/rated_orders_request.dart';
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:beauty_car/home/domain/usecase/appointment_orders_usecase.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';

class AppointmentOrdersViewModel extends BaseViewModel implements AppointmentOrdersViewModelInputs,AppointmentOrdersViewModelOutputs{

  final StreamController _appointmentOrdersStreamController = BehaviorSubject<ModelOrdersResponseRemote>();

  final AppointmentOrdersUseCase _appointmentOrdersUseCase;

  final appointmentOrderRequest = RatedOrdersRequest(true , 6 , "" , 1);

  int page = 1;
  List<Data> appointmentOrdersList = [];

  AppointmentOrdersViewModel(this._appointmentOrdersUseCase);

  //inputs
  @override
  void dispose() {
     super.dispose();
     _appointmentOrdersStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
    getAppointmentOrders();
  }

  @override
  void resetPage() {
    page = 1;
    appointmentOrderRequest.page = 1;
    appointmentOrdersList.clear();
  }

  @override
  Sink get appointmentOrdersData => _appointmentOrdersStreamController.sink;

   var isAppointmentOrdersLoading = false;
   var isOutStateLoading = false;

  Future<void> getAppointmentOrders() async {
    isAppointmentOrdersLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _appointmentOrdersUseCase.execute(appointmentOrderRequest))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isAppointmentOrdersLoading = true;
      appointmentOrdersData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  //outputs
  @override
  Stream<ModelOrdersResponseRemote> get outputAppointmentOrdersData => _appointmentOrdersStreamController.stream.map((data) => data);

   @override
   bool isShowError = false;


}

abstract class AppointmentOrdersViewModelInputs{
   Sink get appointmentOrdersData;
   void resetPage();
}

abstract class AppointmentOrdersViewModelOutputs{
  Stream<ModelOrdersResponseRemote> get outputAppointmentOrdersData;
}
