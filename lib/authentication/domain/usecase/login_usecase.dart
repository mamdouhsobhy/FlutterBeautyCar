
import 'package:beauty_car/authentication/data/response/login/login.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../app/baseUseCase/base_usecase.dart';
import '../../../app/errorHandler/failure.dart';
import '../repository/auth_repository.dart';

class LoginUseCase implements BaseUseCase<FormData,ModelLoginResponseRemote>{
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, ModelLoginResponseRemote>> execute(FormData formData) async{
    return await _repository.login(formData);
  }

}
