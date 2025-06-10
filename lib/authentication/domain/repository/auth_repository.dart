
import 'package:beauty_car/authentication/data/response/forgetPassword/forget_password.dart';
import 'package:beauty_car/authentication/data/response/login/login.dart';
import 'package:beauty_car/authentication/data/response/register/register.dart';
import 'package:beauty_car/authentication/data/response/resetPassword/reset_password.dart';
import 'package:beauty_car/authentication/data/response/sendVerifyCode/send_verify_code.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../app/errorHandler/failure.dart';
import '../../data/response/verifyAccount/verify_account.dart';

abstract class AuthRepository{

  Future<Either<Failure,ModelLoginResponseRemote>> login(FormData formData);

  Future<Either<Failure,ModelRegisterResponseRemote>> register(FormData formData);

  Future<Either<Failure,ModelVerifyAccountResponseRemote>> verifyAccount(FormData formData);

  Future<Either<Failure,ModelSendVerifyCodeResponseRemote>> sendVerifyCode(FormData formData);

  Future<Either<Failure,ModelForgetPasswordResponseRemote>> forgetPassword(FormData formData);

  Future<Either<Failure,ModelResetPasswordResponseRemote>> resetPassword(FormData formData);

}