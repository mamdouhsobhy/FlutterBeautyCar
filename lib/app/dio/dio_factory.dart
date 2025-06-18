import 'package:beauty_car/authentication/data/response/login/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../utils/Constants.dart';
import '../sharedPrefs/app_prefs.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";
const String Apipassword = "Apipassword";

class DioFactory {
  AppPreferences _appPreferences;
  Dio? _dio;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    _dio ??= await _createDio();
    return _dio!;
  }

  Future<void> updateToken(String token) async {
    if (_dio != null) {
      String language = await _appPreferences.getAppLanguage();
      
      Map<String, String> headers = {
        CONTENT_TYPE: APPLICATION_JSON,
        ACCEPT: APPLICATION_JSON,
        AUTHORIZATION: "Bearer $token",
        DEFAULT_LANGUAGE: language,
        Apipassword: "@#\$Beauty@#\$",
        "baseurl": "https://beauty.devxacademy.com/api/v1"
      };

      _dio!.options.headers = headers;
    }
  }

  Future<Dio> _createDio() async {
    Dio dio = Dio();

    String language = await _appPreferences.getAppLanguage();
    ModelLoginResponseRemote? userData = await _appPreferences.getUserData();

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: "Bearer ${Constants.token.isEmpty ? userData?.token : Constants.token}",
      DEFAULT_LANGUAGE: language,
      Apipassword: "@#\$Beauty@#\$",
      "baseurl": "https://beauty.devxacademy.com/api/v1"
    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      receiveTimeout: const Duration(seconds: Constants.apiTimeOut),
      sendTimeout: const Duration(seconds: Constants.apiTimeOut)
    );

    //if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    //}
    return dio;
  }
}