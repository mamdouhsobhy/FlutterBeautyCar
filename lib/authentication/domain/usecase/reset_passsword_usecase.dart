
import 'package:beauty_car/authentication/data/response/resetPassword/reset_password.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../app/baseUseCase/base_usecase.dart';
import '../../../app/errorHandler/failure.dart';
import '../repository/auth_repository.dart';

class ResetPassswordUseCase implements BaseUseCase<FormData,void>{
  final AuthRepository _repository;

  ResetPassswordUseCase(this._repository);

  @override
  Future<Either<Failure, ModelResetPasswordResponseRemote>> execute(FormData formData) async{
    return await _repository.resetPassword(formData);
  }

}
