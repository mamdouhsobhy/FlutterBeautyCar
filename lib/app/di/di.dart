
import 'package:beauty_car/authentication/domain/usecase/forget_passsword_usecase.dart';
import 'package:beauty_car/authentication/domain/usecase/login_usecase.dart';
import 'package:beauty_car/authentication/domain/usecase/register_usecase.dart';
import 'package:beauty_car/authentication/domain/usecase/reset_passsword_usecase.dart';
import 'package:beauty_car/authentication/domain/usecase/verify_code_usecase.dart';
import 'package:beauty_car/authentication/presentation/forgetPasswordScreen/viewmodel/forget_password_viewmodel.dart';
import 'package:beauty_car/authentication/presentation/loginScreen/viewmodel/login_viewmodel.dart';
import 'package:beauty_car/authentication/presentation/registerScreen/viewmodel/register_viewmodel.dart';
import 'package:beauty_car/authentication/presentation/resetPasswordScreen/viewmodel/reset_password_viewmodel.dart';
import 'package:beauty_car/authentication/presentation/verifyCodeScreen/viewmodel/verify_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../authentication/data/data_source/auth_remote_data_source.dart';
import '../../authentication/data/network/auth_api.dart';
import '../../authentication/data/repositoryImp/auth_repository_impl.dart';
import '../../authentication/domain/repository/auth_repository.dart';
import '../dio/dio_factory.dart';
import '../networkInfo/network_info.dart';
import '../sharedPrefs/app_prefs.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async{

  final sharedPrefs = await SharedPreferences.getInstance();
  
  instance.registerLazySingleton<SharedPreferences>(()=>sharedPrefs);

  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();
  //for Authentication
  instance.registerLazySingleton<AuthServiceClient>(() => AuthServiceClient(dio));

  instance.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(instance()));

  instance.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(instance(), instance()));

  //for home
  // instance.registerLazySingleton<HomeServiceClient>(() => HomeServiceClient(dio));
  //
  // instance.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(instance()));
  //
  // instance.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(instance(), instance()));
}

initLoginModule(){

  if(!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }

}

initRegisterModule(){

  if(!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(() => RegisterViewModel(instance()));
  }

}

initVerifyModule(){

  if(!GetIt.I.isRegistered<VerifyCodeUseCase>()) {
    instance.registerFactory<VerifyCodeUseCase>(() => VerifyCodeUseCase(instance()));
    instance.registerFactory<VerifyViewModel>(() => VerifyViewModel(instance()));
  }

}

initForgetPasswordModule(){

  if(!GetIt.I.isRegistered<ForgetPassswordUseCase>()) {
    instance.registerFactory<ForgetPassswordUseCase>(() => ForgetPassswordUseCase(instance()));
    instance.registerFactory<ForgetPasswordViewModel>(() => ForgetPasswordViewModel(instance()));
  }

}

initResetPasswordModule(){

  if(!GetIt.I.isRegistered<ResetPassswordUseCase>()) {
    instance.registerFactory<ResetPassswordUseCase>(() => ResetPassswordUseCase(instance()));
    instance.registerFactory<ResetPasswordViewModel>(() => ResetPasswordViewModel(instance()));
  }

}

