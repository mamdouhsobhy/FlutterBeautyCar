
import 'package:beauty_car/home/data/response/centers/centers.dart';
import 'package:beauty_car/home/data/response/createOrUpdateCenter/create_or_update_center.dart';
import 'package:beauty_car/home/data/response/createOrUpdateEmployee/create_or_update_employee.dart';
import 'package:beauty_car/home/data/response/employees/employees.dart';
import 'package:beauty_car/home/data/response/services/services.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../app/baseUseCase/base_usecase.dart';
import '../../../app/errorHandler/failure.dart';
import '../repository/home_repository.dart';

class CreateEmployeeUseCase implements BaseUseCase<FormData,ModelCreateOrUpdateEmployeeResponseRemote>{
  final HomeRepository _repository;

  CreateEmployeeUseCase(this._repository);

  @override
  Future<Either<Failure, ModelCreateOrUpdateEmployeeResponseRemote>> execute(FormData formData) async{
    return await _repository.createEmployee(formData);
  }

  @override
  Future<Either<Failure, ModelEmployeesResponseRemote>> executeEmployeeDetails(String id) async{
    return await _repository.getEmployeeDetails(id);
  }

  @override
  Future<Either<Failure, ModelCreateOrUpdateEmployeeResponseRemote>> executeUpdateEmployee(String id , FormData formData ,String method) async{
    return await _repository.updateEmployee(id,formData,method);
  }

}
