
import 'package:beauty_car/authentication/data/response/register/register.dart';
import 'package:dio/dio.dart';

import '../network/auth_api.dart';

abstract class AuthRemoteDataSource {
  Future<ModelRegisterResponseRemote> register(FormData formData);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthServiceClient _authServiceClient;

  AuthRemoteDataSourceImpl(this._authServiceClient);

  @override
  Future<ModelRegisterResponseRemote> register(FormData formData) async {
    return await _authServiceClient.register(formData);
  }

}
