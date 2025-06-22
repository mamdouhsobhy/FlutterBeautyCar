
import 'package:beauty_car/home/data/response/employees/employees.dart';
import 'package:beauty_car/home/data/response/services/services.dart';
import 'package:dartz/dartz.dart';
import '../../../app/baseUseCase/base_usecase.dart';
import '../../../app/errorHandler/failure.dart';
import '../repository/home_repository.dart';

class FilterUseCase implements BaseUseCase<int,ModelServicesResponseRemote>{
  final HomeRepository _repository;

  FilterUseCase(this._repository);

  @override
  Future<Either<Failure, ModelServicesResponseRemote>> execute(int limit) async{
    return await _repository.getServices(limit);
  }

  @override
  Future<Either<Failure, ModelEmployeesResponseRemote>> executeEmployees(int limit) async{
    return await _repository.getEmployees(limit);
  }

}
