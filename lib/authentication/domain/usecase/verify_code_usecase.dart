
import 'package:beauty_car/authentication/data/response/register/register.dart';
import 'package:beauty_car/authentication/data/response/sendVerifyCode/send_verify_code.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../app/baseUseCase/base_usecase.dart';
import '../../../app/errorHandler/failure.dart';
import '../../data/response/verifyAccount/verify_account.dart';
import '../repository/auth_repository.dart';

class VerifyCodeUseCase implements BaseUseCase<FormData,void>{
  final AuthRepository _repository;

  VerifyCodeUseCase(this._repository);

  @override
  Future<Either<Failure, ModelVerifyAccountResponseRemote>> execute(FormData formData) async{
    return await _repository.verifyAccount(formData);
  }

  @override
  Future<Either<Failure, ModelSendVerifyCodeResponseRemote>> executeSendVerifyCode(FormData formData) async{
    return await _repository.sendVerifyCode(formData);
  }

}
