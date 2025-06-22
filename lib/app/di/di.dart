
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
import 'package:beauty_car/home/domain/usecase/centers_usecase.dart';
import 'package:beauty_car/home/domain/usecase/create_center_usecase.dart';
import 'package:beauty_car/home/domain/usecase/employee_details_usecase.dart';
import 'package:beauty_car/home/domain/usecase/employee_usecase.dart';
import 'package:beauty_car/home/domain/usecase/home_usecase.dart';
import 'package:beauty_car/home/domain/usecase/order_details_usecase.dart';
import 'package:beauty_car/home/domain/usecase/orders_usecase.dart';
import 'package:beauty_car/home/presentation/centerPageScreen/viewmodel/centers_viewmodel.dart';
import 'package:beauty_car/home/presentation/createCenterScreen/viewmodel/create_center_viewmodel.dart';
import 'package:beauty_car/home/presentation/employeeDetailsPageScreen/viewmodel/employee_details_viewmodel.dart';
import 'package:beauty_car/home/presentation/employeePageScreen/viewmodel/employee_viewmodel.dart';
import 'package:beauty_car/home/presentation/homePageScreen/viewmodel/home_viewmodel.dart';
import 'package:beauty_car/home/presentation/moreOrdersPageScreen/viewmodel/more_orders_viewmodel.dart';
import 'package:beauty_car/home/presentation/orderPageScreen/viewmodel/orders_viewmodel.dart';
import 'package:beauty_car/home/presentation/reserveDetailsPageScreen/viewmodel/order_details_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../authentication/data/data_source/auth_remote_data_source.dart';
import '../../authentication/data/network/auth_api.dart';
import '../../authentication/data/repositoryImp/auth_repository_impl.dart';
import '../../authentication/domain/repository/auth_repository.dart';
import '../../home/data/data_source/home_remote_data_source.dart';
import '../../home/data/network/home_api.dart';
import '../../home/data/repositoryImp/home_repository_impl.dart';
import '../../home/domain/repository/home_repository.dart';
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
   instance.registerLazySingleton<HomeServiceClient>(() => HomeServiceClient(dio));
  //
   instance.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(instance()));
  //
   instance.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(instance(), instance()));
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


initHomeModule(){

  if(!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
    instance.registerFactory<MoreOrdersViewModel>(() => MoreOrdersViewModel(instance()));
  }

}


initCentersModule(){

  if(!GetIt.I.isRegistered<CentersUseCase>()) {
    instance.registerFactory<CentersUseCase>(() => CentersUseCase(instance()));
    instance.registerFactory<CentersViewModel>(() => CentersViewModel(instance()));
  }

}

initCreateCentersModule(){

  if(!GetIt.I.isRegistered<CreateCenterUseCase>()) {
    instance.registerFactory<CreateCenterUseCase>(() => CreateCenterUseCase(instance()));
    instance.registerFactory<CreateCenterViewModel>(() => CreateCenterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());

  }

}

initOrdersModule(){

  if(!GetIt.I.isRegistered<OrdersUseCase>()) {
    instance.registerFactory<OrdersUseCase>(() => OrdersUseCase(instance()));
    instance.registerFactory<OrdersViewModel>(() => OrdersViewModel(instance()));
  }

}

initOrderDetailsModule(){

  if(!GetIt.I.isRegistered<OrderDetailsUseCase>()) {
    instance.registerFactory<OrderDetailsUseCase>(() => OrderDetailsUseCase(instance()));
    instance.registerFactory<OrderDetailsViewModel>(() => OrderDetailsViewModel(instance()));
  }

}

initEmployeeModule(){

  if(!GetIt.I.isRegistered<EmployeeUseCase>()) {
    instance.registerFactory<EmployeeUseCase>(() => EmployeeUseCase(instance()));
    instance.registerFactory<EmployeeViewModel>(() => EmployeeViewModel(instance()));
  }

}

initEmployeeDetailsModule(){

  if(!GetIt.I.isRegistered<EmployeeDetailsUseCase>()) {
    instance.registerFactory<EmployeeDetailsUseCase>(() => EmployeeDetailsUseCase(instance()));
    instance.registerFactory<EmployeeDetailsViewModel>(() => EmployeeDetailsViewModel(instance()));
  }

}




