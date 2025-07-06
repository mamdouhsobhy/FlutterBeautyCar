
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
import 'package:beauty_car/home/domain/usecase/appointment_orders_usecase.dart';
import 'package:beauty_car/home/domain/usecase/centers_usecase.dart';
import 'package:beauty_car/home/domain/usecase/create_center_usecase.dart';
import 'package:beauty_car/home/domain/usecase/create_employee_usecase.dart';
import 'package:beauty_car/home/domain/usecase/delete_account_usecase.dart';
import 'package:beauty_car/home/domain/usecase/employee_details_usecase.dart';
import 'package:beauty_car/home/domain/usecase/employee_usecase.dart';
import 'package:beauty_car/home/domain/usecase/home_usecase.dart';
import 'package:beauty_car/home/domain/usecase/order_details_usecase.dart';
import 'package:beauty_car/home/domain/usecase/orders_usecase.dart';
import 'package:beauty_car/home/domain/usecase/profile_usecase.dart';
import 'package:beauty_car/home/domain/usecase/rated_orders_usecase.dart';
import 'package:beauty_car/home/domain/usecase/settings_usecase.dart';
import 'package:beauty_car/home/presentation/centerPageScreen/viewmodel/centers_viewmodel.dart';
import 'package:beauty_car/home/presentation/changePasswordScreen/viewmodel/change_password_viewmodel.dart';
import 'package:beauty_car/home/presentation/createCenterScreen/viewmodel/create_center_viewmodel.dart';
import 'package:beauty_car/home/presentation/createEmployeeScreen/viewmodel/create_employee_viewmodel.dart';
import 'package:beauty_car/home/presentation/deleteAccountScreen/viewmodel/delete_account_viewmodel.dart';
import 'package:beauty_car/home/presentation/editProfileScreen/viewmodel/profile_viewmodel.dart';
import 'package:beauty_car/home/presentation/employeeAppointmentPageScreen/viewmodel/appointment_orders_viewmodel.dart';
import 'package:beauty_car/home/presentation/employeeDetailsPageScreen/viewmodel/employee_details_viewmodel.dart';
import 'package:beauty_car/home/presentation/employeePageScreen/viewmodel/employee_viewmodel.dart';
import 'package:beauty_car/home/presentation/employee_review_page_screen/viewmodel/review_orders_viewmodel.dart';
import 'package:beauty_car/home/presentation/homePageScreen/viewmodel/home_viewmodel.dart';
import 'package:beauty_car/home/presentation/moreOrdersPageScreen/viewmodel/more_orders_viewmodel.dart';
import 'package:beauty_car/home/presentation/orderPageScreen/viewmodel/orders_viewmodel.dart';
import 'package:beauty_car/home/presentation/reserveDetailsPageScreen/viewmodel/order_details_viewmodel.dart';
import 'package:beauty_car/home/presentation/settingPageScreen/viewmodel/setting_viewmodel.dart';
import 'package:beauty_car/home/presentation/termsAndConditionScreen/viewmodel/terms_and_condition_viewmodel.dart';
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
final appPrefs = instance<AppPreferences>();

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

initCreateEmployeeModule(){

  if(!GetIt.I.isRegistered<CreateEmployeeUseCase>()) {
    instance.registerFactory<CreateEmployeeUseCase>(() => CreateEmployeeUseCase(instance()));
    instance.registerFactory<CreateEmployeeViewModel>(() => CreateEmployeeViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }

}

initEmployeeReviewModule(){

  if(!GetIt.I.isRegistered<RatedOrdersUseCase>()) {
    instance.registerFactory<RatedOrdersUseCase>(() => RatedOrdersUseCase(instance()));
    instance.registerFactory<ReviewOrdersViewModel>(() => ReviewOrdersViewModel(instance()));
  }

}

initEmployeeAppointmentOrderModule(){

  if(!GetIt.I.isRegistered<AppointmentOrdersUseCase>()) {
    instance.registerFactory<AppointmentOrdersUseCase>(() => AppointmentOrdersUseCase(instance()));
    instance.registerFactory<AppointmentOrdersViewModel>(() => AppointmentOrdersViewModel(instance()));
  }

}

initEditProfileModule(){

  if(!GetIt.I.isRegistered<ProfileUseCase>()) {
    instance.registerFactory<ProfileUseCase>(() => ProfileUseCase(instance()));
    instance.registerFactory<ProfileViewModel>(() => ProfileViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }

}

initChangePasswordModule(){

  if(!GetIt.I.isRegistered<ProfileUseCase>()) {
    instance.registerFactory<ProfileUseCase>(() => ProfileUseCase(instance()));
    instance.registerFactory<ChangePasswordViewModel>(() => ChangePasswordViewModel(instance()));
  }

}

initSettingModule(){

  if(!GetIt.I.isRegistered<SettingsUseCase>()) {
    instance.registerFactory<SettingsUseCase>(() => SettingsUseCase(instance()));
    instance.registerFactory<TermsAndConditionViewModel>(() => TermsAndConditionViewModel(instance()));
    instance.registerFactory<SettingViewModel>(() => SettingViewModel(instance()));
  }


}


initDeleteAccountModule(){

  if(!GetIt.I.isRegistered<DeleteAccountUseCase>()) {
    instance.registerFactory<DeleteAccountUseCase>(() => DeleteAccountUseCase(instance()));
    instance.registerFactory<DeleteAccountViewModel>(() => DeleteAccountViewModel(instance()));
  }

}





