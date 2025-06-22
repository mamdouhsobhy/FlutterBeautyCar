
import 'dart:async';
import 'package:beauty_car/home/data/response/employees/employees.dart';
import 'package:beauty_car/home/data/response/services/services.dart';
import 'package:beauty_car/home/domain/usecase/filter_usecase.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';

class CreateCenterViewModel extends BaseViewModel implements CreateCenterViewModelInputs,CreateCenterViewModelOutputs{

  final StreamController _servicesStreamController = BehaviorSubject<ModelServicesResponseRemote>();
  final StreamController _employeesStreamController = BehaviorSubject<ModelEmployeesResponseRemote>();

  final FilterUseCase _filterUseCase;

  CreateCenterViewModel(this._filterUseCase);

  List<Services> services = [];

  //inputs
  @override
  void dispose() {
     super.dispose();
     _servicesStreamController.close();
     _employeesStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get servicesData => _servicesStreamController.sink;

  @override
  Sink get employeesData => _employeesStreamController.sink;

   var isServicesLoading = false;
   var isEmployeesLoading = false;
   var isOutStateLoading = false;

  Future<void> getServices() async {
    isServicesLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _filterUseCase.execute(50))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isServicesLoading = true;
      servicesData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  Future<void> getEmployees() async {
    isEmployeesLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _filterUseCase.executeEmployees(50))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isEmployeesLoading = true;
      employeesData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  //outputs
  @override
  Stream<ModelServicesResponseRemote> get outputServicesData => _servicesStreamController.stream.map((data) => data);

  @override
  Stream<ModelEmployeesResponseRemote> get outputEmployeesData => _employeesStreamController.stream.map((data) => data);

  @override
   bool isShowError = false;


}

abstract class CreateCenterViewModelInputs{
   Sink get servicesData;
   Sink get employeesData;
}

abstract class CreateCenterViewModelOutputs{
  Stream<ModelServicesResponseRemote> get outputServicesData;
  Stream<ModelEmployeesResponseRemote> get outputEmployeesData;
}
