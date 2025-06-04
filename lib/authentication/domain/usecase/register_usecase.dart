
import 'package:beauty_car/authentication/data/response/register/register.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../app/baseUseCase/base_usecase.dart';
import '../../../app/errorHandler/failure.dart';
import '../repository/auth_repository.dart';

class RegisterUseCase implements BaseUseCase<FormData,ModelRegisterResponseRemote>{
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, ModelRegisterResponseRemote>> execute(FormData formData) async{
    return await _repository.register(formData);
  }

}
