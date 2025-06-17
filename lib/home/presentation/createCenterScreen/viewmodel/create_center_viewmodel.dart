
import 'dart:async';
import 'package:beauty_car/home/data/response/centers/centers.dart';
import 'package:beauty_car/home/data/response/createOrUpdateCenter/create_or_update_center.dart';
import 'package:beauty_car/home/data/response/employees/employees.dart';
import 'package:beauty_car/home/data/response/services/services.dart';
import 'package:beauty_car/home/domain/usecase/create_center_usecase.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/baseViewModel/baseViewModel.dart';
import '../../../../app/state_renderer/state_renderer.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../data/request/create_or_update_center.dart';

class CreateCenterViewModel extends BaseViewModel implements CreateCenterViewModelInputs,CreateCenterViewModelOutputs{

  final StreamController _servicesStreamController = BehaviorSubject<ModelServicesResponseRemote>();
  final StreamController _employeesStreamController = BehaviorSubject<ModelEmployeesResponseRemote>();
  final StreamController _createOrUpdateCenterStreamController = BehaviorSubject<ModelCreateOrUpdateCenterResponseRemote>();
  final StreamController _centerStreamController = BehaviorSubject<ModelCentersResponseRemote>();

  final CreateCenterUseCase _createCenterUseCase;

  CreateCenterViewModel(this._createCenterUseCase);

  final createOrUpdateCenter = CreateOrUpdateCenter("","","","",null,"","","","","");

  bool isCenterFirstLoad = false;
  List<Services> services = [];

  //inputs
  @override
  void dispose() {
     super.dispose();
     _servicesStreamController.close();
     _employeesStreamController.close();
     _createOrUpdateCenterStreamController.close();
     _centerStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get servicesData => _servicesStreamController.sink;

  @override
  Sink get employeesData => _employeesStreamController.sink;

  @override
  Sink get createOrUpdateCenterData => _createOrUpdateCenterStreamController.sink;

  @override
  Sink get centerData => _centerStreamController.sink;

   var isServicesLoading = false;
   var isEmployeesLoading = false;
   var isCreateCenterLoading = false;
   var isCenterLoading = false;
   var isOutStateLoading = false;

  Future<void> getServices() async {
    isServicesLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _createCenterUseCase.executeServices(50))
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

    (await _createCenterUseCase.executeEmployees(50))
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

  Future<void> createCenter() async {
    isCreateCenterLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _createCenterUseCase.execute(await buildCreateCenterFormData()))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isCreateCenterLoading = true;
      createOrUpdateCenterData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  Future<void> getCenterDetails() async {
    isCenterLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _createCenterUseCase.executeCenterDetails(createOrUpdateCenter.centerId))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isCenterLoading = true;
      if (!_centerStreamController.isClosed) {
        centerData.add(data);
      }
      inputState.add(SuccessState(""));
    },
    );
  }

  Future<void> updateCenter() async {
    isCreateCenterLoading = false;
    isOutStateLoading = true;

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _createCenterUseCase.executeUpdateCenter(createOrUpdateCenter.centerId,await buildCreateCenterFormData(),"patch"))
        .fold(
          (failure) {
        inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      }, (data) {
      isCreateCenterLoading = true;
      createOrUpdateCenterData.add(data);
      inputState.add(SuccessState(""));
    },
    );
  }

  Future<FormData> buildCreateCenterFormData() async {
    final formData = FormData();
    formData.fields.addAll([
      MapEntry("name", createOrUpdateCenter.centerName),
      MapEntry("address", createOrUpdateCenter.address),
      MapEntry("phone", createOrUpdateCenter.phone),
      MapEntry("employee_id", createOrUpdateCenter.employeeId.toString()),
      MapEntry("open_time", createOrUpdateCenter.openTime),
      MapEntry("close_time", createOrUpdateCenter.closedTime),
      MapEntry("status", createOrUpdateCenter.status.toString()),
    ]);

    if(createOrUpdateCenter.image != null) {
      formData.files.add(MapEntry(
        "image",
        await MultipartFile.fromFile(createOrUpdateCenter.image!.path),
      ));
    }

    for (var service in services) {
      formData.fields.add(MapEntry("service_ids[]", service.id.toString()));
    }

    return formData;
  }


  //outputs
  @override
  Stream<ModelServicesResponseRemote> get outputServicesData => _servicesStreamController.stream.map((data) => data);

  @override
  Stream<ModelEmployeesResponseRemote> get outputEmployeesData => _employeesStreamController.stream.map((data) => data);

  @override
  Stream<ModelCreateOrUpdateCenterResponseRemote> get outputCreateOrUpdateCenterData => _createOrUpdateCenterStreamController.stream.map((data) => data);

  @override
  Stream<ModelCentersResponseRemote> get outputCenterData => _centerStreamController.stream.map((data) => data);

  @override
   bool isShowError = false;


}

abstract class CreateCenterViewModelInputs{
   Sink get servicesData;
   Sink get employeesData;
   Sink get createOrUpdateCenterData;
   Sink get centerData;
}

abstract class CreateCenterViewModelOutputs{
  Stream<ModelServicesResponseRemote> get outputServicesData;
  Stream<ModelEmployeesResponseRemote> get outputEmployeesData;
  Stream<ModelCreateOrUpdateCenterResponseRemote> get outputCreateOrUpdateCenterData;
  Stream<ModelCentersResponseRemote> get outputCenterData;
}
