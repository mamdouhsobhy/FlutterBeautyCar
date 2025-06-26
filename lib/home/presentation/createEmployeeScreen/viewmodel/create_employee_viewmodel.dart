
import 'dart:async';
import 'package:beauty_car/home/data/response/createOrUpdateEmployee/create_or_update_employee.dart';
import 'package:beauty_car/home/data/response/employees/employees.dart';
import 'package:beauty_car/home/domain/usecase/create_employee_usecase.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../data/request/create_or_update_employee.dart';

class CreateEmployeeViewModel extends BaseViewModel implements CreateEmployeeViewModelInputs,CreateEmployeeViewModelOutputs{

  final StreamController _employeesStreamController = BehaviorSubject<ModelEmployeesResponseRemote>();
  final StreamController _createOrUpdateEmployeeStreamController = BehaviorSubject<ModelCreateOrUpdateEmployeeResponseRemote>();

  final CreateEmployeeUseCase _createEmployeeUseCase;

  CreateEmployeeViewModel(this._createEmployeeUseCase);

  final createOrUpdateEmployee = CreateOrUpdateEmployee("","","","","","","","","","","",null);

  bool isEmployeeFirstLoad = false;

  //inputs
  @override
  void dispose() {
     super.dispose();
     _employeesStreamController.close();
     _createOrUpdateEmployeeStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get employeeData => _employeesStreamController.sink;

  @override
  Sink get createOrUpdateEmployeeData => _createOrUpdateEmployeeStreamController.sink;

   var isEmployeeLoading = false;
   var isCreateEmployeeLoading = false;
   var isOutStateLoading = false;

  Future<void> getEmployeeDetails(String empId) async {
    isEmployeeLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _createEmployeeUseCase.executeEmployeeDetails(empId))
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

  Future<void> createEmployee() async {
    isCreateEmployeeLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _createEmployeeUseCase.execute(await buildCreateEmployeeFormData()))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isCreateEmployeeLoading = true;
      createOrUpdateEmployeeData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  Future<void> updateEmployee() async {
    isCreateEmployeeLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _createEmployeeUseCase.executeUpdateEmployee(createOrUpdateEmployee.employeeId,await buildCreateEmployeeFormData(),"patch"))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isCreateEmployeeLoading = true;
      createOrUpdateEmployeeData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  Future<FormData> buildCreateEmployeeFormData() async {
    final formData = FormData();
    formData.fields.addAll([
      MapEntry("name", createOrUpdateEmployee.name),
      MapEntry("email", createOrUpdateEmployee.email),
      MapEntry("phone", createOrUpdateEmployee.phone),
      MapEntry("password", createOrUpdateEmployee.password),
      MapEntry("password_confirmation", createOrUpdateEmployee.password_confirmation),
      MapEntry("experiance", createOrUpdateEmployee.experiance),
      MapEntry("ssd_num", createOrUpdateEmployee.ssd_num),
      MapEntry("start_time", createOrUpdateEmployee.start_time),
      MapEntry("end_time", createOrUpdateEmployee.end_time),
      MapEntry("status", createOrUpdateEmployee.status),
    ]);

    if(createOrUpdateEmployee.image != null) {
      formData.files.add(MapEntry(
        "image",
        await MultipartFile.fromFile(createOrUpdateEmployee.image!.path),
      ));
    }

    return formData;
  }


  //outputs
  @override
  Stream<ModelEmployeesResponseRemote> get outputEmployeesData => _employeesStreamController.stream.map((data) => data);

  @override
  Stream<ModelCreateOrUpdateEmployeeResponseRemote> get outputCreateOrUpdateEmployeeData => _createOrUpdateEmployeeStreamController.stream.map((data) => data);

  @override
   bool isShowError = false;


}

abstract class CreateEmployeeViewModelInputs{
   Sink get createOrUpdateEmployeeData;
   Sink get employeeData;
}

abstract class CreateEmployeeViewModelOutputs{
  Stream<ModelEmployeesResponseRemote> get outputEmployeesData;
  Stream<ModelCreateOrUpdateEmployeeResponseRemote> get outputCreateOrUpdateEmployeeData;
}
