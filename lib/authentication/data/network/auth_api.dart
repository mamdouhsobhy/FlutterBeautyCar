import 'package:beauty_car/authentication/data/response/forgetPassword/forget_password.dart';
import 'package:beauty_car/authentication/data/response/login/login.dart';
import 'package:beauty_car/authentication/data/response/register/register.dart';
import 'package:beauty_car/authentication/data/response/resetPassword/reset_password.dart';
import 'package:beauty_car/authentication/data/response/sendVerifyCode/send_verify_code.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../utils/Constants.dart';
import '../response/verifyAccount/verify_account.dart';
part 'auth_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AuthServiceClient{
  factory AuthServiceClient(Dio dio,{String baseUrl}) = _AuthServiceClient;

  @MultiPart()
  @POST("guest/login")
  Future<ModelLoginResponseRemote> login(@Body() FormData formData);

  @MultiPart()
  @POST("guest/register")
  Future<ModelRegisterResponseRemote> register(@Body() FormData formData);

  @MultiPart()
  @POST("guest/verifyAccount")
  Future<ModelVerifyAccountResponseRemote> verifyAccount(@Body() FormData formData);

  @MultiPart()
  @POST("guest/sendVerifiyCode")
  Future<ModelSendVerifyCodeResponseRemote> sendVerifyCode(@Body() FormData formData);

  @MultiPart()
  @POST("guest/forgetPassword")
  Future<ModelForgetPasswordResponseRemote> forgetPassword(@Body() FormData formData);

  @MultiPart()
  @POST("guest/resetPassword")
  Future<ModelResetPasswordResponseRemote> resetPassword(@Body() FormData formData);

}