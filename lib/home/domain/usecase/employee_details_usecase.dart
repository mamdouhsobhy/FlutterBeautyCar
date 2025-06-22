
import 'package:beauty_car/home/data/request/employee_details_request.dart';
import 'package:beauty_car/home/data/response/employees/employees.dart';
import 'package:dartz/dartz.dart';
import '../../../app/baseUseCase/base_usecase.dart';
import '../../../app/errorHandler/failure.dart';
import '../repository/home_repository.dart';

class EmployeeDetailsUseCase implements BaseUseCase<EmployeeDetailsRequest,ModelEmployeesResponseRemote>{
  final HomeRepository _repository;

  EmployeeDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, ModelEmployeesResponseRemote>> execute(EmployeeDetailsRequest request) async{
    return await _repository.getEmployeeDetails(request.empId);
  }

}

