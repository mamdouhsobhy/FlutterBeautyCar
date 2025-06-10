
import 'package:beauty_car/authentication/data/response/forgetPassword/forget_password.dart';
import 'package:beauty_car/authentication/data/response/sendVerifyCode/send_verify_code.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../app/baseUseCase/base_usecase.dart';
import '../../../app/errorHandler/failure.dart';
import '../../data/response/verifyAccount/verify_account.dart';
import '../repository/auth_repository.dart';

class ForgetPassswordUseCase implements BaseUseCase<FormData,void>{
  final AuthRepository _repository;

  ForgetPassswordUseCase(this._repository);

  @override
  Future<Either<Failure, ModelForgetPasswordResponseRemote>> execute(FormData formData) async{
    return await _repository.forgetPassword(formData);
  }


}
