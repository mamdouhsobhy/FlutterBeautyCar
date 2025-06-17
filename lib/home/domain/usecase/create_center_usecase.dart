
import 'package:beauty_car/home/data/response/centers/centers.dart';
import 'package:beauty_car/home/data/response/createOrUpdateCenter/create_or_update_center.dart';
import 'package:beauty_car/home/data/response/employees/employees.dart';
import 'package:beauty_car/home/data/response/services/services.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../app/baseUseCase/base_usecase.dart';
import '../../../app/errorHandler/failure.dart';
import '../repository/home_repository.dart';

class CreateCenterUseCase implements BaseUseCase<FormData,ModelCreateOrUpdateCenterResponseRemote>{
  final HomeRepository _repository;

  CreateCenterUseCase(this._repository);

  @override
  Future<Either<Failure, ModelCreateOrUpdateCenterResponseRemote>> execute(FormData formData) async{
    return await _repository.createCenter(formData);
  }

  @override
  Future<Either<Failure, ModelServicesResponseRemote>> executeServices(int limit) async{
    return await _repository.getServices(limit);
  }

  @override
  Future<Either<Failure, ModelEmployeesResponseRemote>> executeEmployees(int limit) async{
    return await _repository.getEmployees(limit);
  }

  @override
  Future<Either<Failure, ModelCentersResponseRemote>> executeCenterDetails(String id) async{
    return await _repository.getCenterDetails(id);
  }

  @override
  Future<Either<Failure, ModelCreateOrUpdateCenterResponseRemote>> executeUpdateCenter(String id , FormData formData ,String method) async{
    return await _repository.updateCenter(id,formData,method);
  }

}
