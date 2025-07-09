
import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:beauty_car/authentication/data/response/login/login.dart';
import 'package:beauty_car/home/data/response/centers/centers.dart';
import 'package:beauty_car/home/data/response/completeOrder/complete_order.dart';
import 'package:beauty_car/home/data/response/createOrUpdateCenter/create_or_update_center.dart';
import 'package:beauty_car/home/data/response/createOrUpdateEmployee/create_or_update_employee.dart';
import 'package:beauty_car/home/data/response/employees/employees.dart';
import 'package:beauty_car/home/data/response/getHomeStatistics/get_home_statistics.dart';
import 'package:beauty_car/home/data/response/getRatedOrders/get_rated_orders.dart';
import 'package:beauty_car/home/data/response/getSettings/get_settings.dart';
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:beauty_car/home/data/response/services/services.dart';
import 'package:beauty_car/home/data/response/updateOrderStatus/update_order_status.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../app/errorHandler/failure.dart';

abstract class HomeRepository {

  Future<Either<Failure,ModelOrdersResponseRemote>> getHomeOrders(bool pagination,int limit, int page , int status);

  Future<Either<Failure,ModelCentersResponseRemote>> getCenters(bool pagination , int limit , int page);

  Future<Either<Failure,ModelCreateOrUpdateCenterResponseRemote>> createCenter(FormData formData);

  Future<Either<Failure,ModelServicesResponseRemote>> getServices(int limit);

  Future<Either<Failure,ModelEmployeesResponseRemote>> getEmployees(int limit);

  Future<Either<Failure,ModelCentersResponseRemote>> getCenterDetails(String id);

  Future<Either<Failure,ModelCreateOrUpdateCenterResponseRemote>> updateCenter(String id , FormData formData ,String method);

  Future<Either<Failure,ModelOrdersResponseRemote>> getOrdersWithStatus(bool pagination , int limit , int page , int status);

  Future<Either<Failure,ModelUpdateOrderStatusResponseRemote>> updateOrderStatus(String id , String reason , int status);

  Future<Either<Failure,ModelOrdersResponseRemote>> getOrderDetails(String id);

  Future<Either<Failure,ModelEmployeesResponseRemote>> getEmployeeDetails(String empId);

  Future<Either<Failure,ModelCreateOrUpdateEmployeeResponseRemote>> createEmployee(FormData formData);

  Future<Either<Failure,ModelCreateOrUpdateEmployeeResponseRemote>> updateEmployee(String id , FormData formData ,String method);

  Future<Either<Failure,ModelGetRatedOrdersResponseRemote>> getRatedOrders(bool pagination , int limit , String empId , int page );

  Future<Either<Failure,ModelOrdersResponseRemote>> getAppointmentOrders(bool pagination , int limit , String empId , int page );

  Future<Either<Failure,ModelGetHomeStatisticsResponseRemote>> getHomeStatistics();

  Future<Either<Failure,ModelLoginResponseRemote>> updateProfile(FormData data);

  Future<Either<Failure,BaseResponse>> changePassword(FormData data);

  Future<Either<Failure,ModelGetSettingsResponseRemote>> getSettings();

  Future<Either<Failure,ModelLoginResponseRemote>> deleteAccount(FormData data);

  Future<Either<Failure,ModelLoginResponseRemote>> updateNotification(FormData data);

  Future<Either<Failure,ModelCompleteOrderResponseRemote>> completeOrder(FormData data);

}