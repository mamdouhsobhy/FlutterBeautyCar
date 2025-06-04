
import 'package:beauty_car/authentication/data/response/login/login.dart';
import 'package:beauty_car/authentication/data/response/register/register.dart';
import 'package:beauty_car/authentication/data/response/sendVerifyCode/send_verify_code.dart';
import 'package:dio/dio.dart';

import '../network/auth_api.dart';
import '../response/verifyAccount/verify_account.dart';

abstract class AuthRemoteDataSource {
  Future<ModelLoginResponseRemote> login(FormData formData);

  Future<ModelRegisterResponseRemote> register(FormData formData);

  Future<ModelVerifyAccountResponseRemote> verifyAccount(FormData formData);

  Future<ModelSendVerifyCodeResponseRemote> sendVerifyCode(FormData formData);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthServiceClient _authServiceClient;

  AuthRemoteDataSourceImpl(this._authServiceClient);

  @override
  Future<ModelLoginResponseRemote> login(FormData formData) async {
    return await _authServiceClient.login(formData);
  }

  @override
  Future<ModelRegisterResponseRemote> register(FormData formData) async {
    return await _authServiceClient.register(formData);
  }

  @override
  Future<ModelSendVerifyCodeResponseRemote> sendVerifyCode(FormData formData) async{
    return await _authServiceClient.sendVerifyCode(formData);
  }

  @override
  Future<ModelVerifyAccountResponseRemote> verifyAccount(FormData formData) async{
    return await _authServiceClient.verifyAccount(formData);
  }

}
