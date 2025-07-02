import 'dart:async';
import 'package:beauty_car/home/data/response/employees/employees.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../domain/usecase/employee_usecase.dart';

class EmployeeViewModel extends BaseViewModel implements EmployeeViewModelInputs,EmployeeViewModelOutputs{

  final StreamController _employeesStreamController = BehaviorSubject<ModelEmployeesResponseRemote>();

  final EmployeeUseCase _employeeUseCase;

  EmployeeViewModel(this._employeeUseCase);

  List<Data> employeesList = [];

  //inputs
  @override
  void dispose() {
     super.dispose();
     _employeesStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
    getEmployees();
  }

  @override
  void resetPage() {
    employeesList.clear();
  }

  @override
  Sink get employeesData => _employeesStreamController.sink;

   var isEmployeesLoading = false;
   var isOutStateLoading = false;

  Future<void> getEmployees() async {
    isEmployeesLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _employeeUseCase.execute(100))
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
  Stream<ModelEmployeesResponseRemote> get outputEmployeesData => _employeesStreamController.stream.map((data) => data);

  @override
   bool isShowError = false;


}

abstract class EmployeeViewModelInputs{
   Sink get employeesData;
}

abstract class EmployeeViewModelOutputs{
  Stream<ModelEmployeesResponseRemote> get outputEmployeesData;
}
