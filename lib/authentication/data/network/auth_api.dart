import 'package:beauty_car/authentication/data/response/register/register.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../utils/Constants.dart';
part 'auth_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AuthServiceClient{
  factory AuthServiceClient(Dio dio,{String baseUrl}) = _AuthServiceClient;

  @MultiPart()
  @POST("guest/register")
  Future<ModelRegisterResponseRemote> register(@Body() FormData formData);


}