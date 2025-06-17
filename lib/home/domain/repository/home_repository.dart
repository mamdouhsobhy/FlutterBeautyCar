
import 'package:beauty_car/home/data/response/centers/centers.dart';
import 'package:beauty_car/home/data/response/createOrUpdateCenter/create_or_update_center.dart';
import 'package:beauty_car/home/data/response/employees/employees.dart';
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:beauty_car/home/data/response/services/services.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../app/errorHandler/failure.dart';

abstract class HomeRepository {

  Future<Either<Failure,ModelOrdersResponseRemote>> getHomeOrders(int limit);

  Future<Either<Failure,ModelCentersResponseRemote>> getCenters(bool pagination , int limit , int page);

  Future<Either<Failure,ModelCreateOrUpdateCenterResponseRemote>> createCenter(FormData formData);

  Future<Either<Failure,ModelServicesResponseRemote>> getServices(int limit);

  Future<Either<Failure,ModelEmployeesResponseRemote>> getEmployees(int limit);

  Future<Either<Failure,ModelCentersResponseRemote>> getCenterDetails(String id);

  Future<Either<Failure,ModelCreateOrUpdateCenterResponseRemote>> updateCenter(String id , FormData formData ,String method);

}