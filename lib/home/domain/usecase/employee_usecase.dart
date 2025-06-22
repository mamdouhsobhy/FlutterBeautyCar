
import 'package:beauty_car/home/data/response/employees/employees.dart';
import 'package:dartz/dartz.dart';
import '../../../app/baseUseCase/base_usecase.dart';
import '../../../app/errorHandler/failure.dart';
import '../repository/home_repository.dart';

class EmployeeUseCase implements BaseUseCase<int,ModelEmployeesResponseRemote>{
  final HomeRepository _repository;

  EmployeeUseCase(this._repository);

  @override
  Future<Either<Failure, ModelEmployeesResponseRemote>> execute(int limit) async{
    return await _repository.getEmployees(limit);
  }

}
