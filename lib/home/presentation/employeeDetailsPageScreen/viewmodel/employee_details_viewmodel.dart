
import 'dart:async';
import 'package:beauty_car/home/data/request/employee_details_request.dart';
import 'package:beauty_car/home/data/response/employees/employees.dart';
import 'package:beauty_car/home/domain/usecase/employee_details_usecase.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';

class EmployeeDetailsViewModel extends BaseViewModel implements EmployeeDetailsViewModelInputs,EmployeeDetailsViewModelOutputs{

  final StreamController _employeeStreamController = BehaviorSubject<ModelEmployeesResponseRemote>();

  final EmployeeDetailsUseCase _employeeDetailsUseCase;

  EmployeeDetailsViewModel(this._employeeDetailsUseCase);

  bool isCenterFirstLoad = false;

  //inputs
  @override
  void dispose() {
     super.dispose();
     _employeeStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get employeeData => _employeeStreamController.sink;

   var isEmployeeLoading = false;
   var isOutStateLoading = false;

  Future<void> getEmployeeDetails(String empId) async {
    isEmployeeLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _employeeDetailsUseCase.execute(EmployeeDetailsRequest(empId)))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isEmployeeLoading = true;
      employeeData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  //outputs
  @override
  Stream<ModelEmployeesResponseRemote> get outputEmployeeData => _employeeStreamController.stream.map((data) => data);

  @override
   bool isShowError = false;


}

abstract class EmployeeDetailsViewModelInputs{
   Sink get employeeData;
}

abstract class EmployeeDetailsViewModelOutputs{
  Stream<ModelEmployeesResponseRemote> get outputEmployeeData;
}
