
import 'package:beauty_car/home/data/network/home_api.dart';
import 'package:beauty_car/home/data/response/centers/centers.dart';
import 'package:beauty_car/home/data/response/createOrUpdateCenter/create_or_update_center.dart';
import 'package:beauty_car/home/data/response/createOrUpdateEmployee/create_or_update_employee.dart';
import 'package:beauty_car/home/data/response/employees/employees.dart';
import 'package:beauty_car/home/data/response/getHomeStatistics/get_home_statistics.dart';
import 'package:beauty_car/home/data/response/getRatedOrders/get_rated_orders.dart';
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:beauty_car/home/data/response/services/services.dart';
import 'package:beauty_car/home/data/response/updateOrderStatus/update_order_status.dart';
import 'package:dio/dio.dart';

abstract class HomeRemoteDataSource {
  Future<ModelOrdersResponseRemote> getHomeOrders(bool pagination , int limit , int status);

  Future<ModelCentersResponseRemote> getCenters(bool pagination , int limit , int page);

  Future<ModelCreateOrUpdateCenterResponseRemote> createCenter(FormData formData);

  Future<ModelServicesResponseRemote> getServices(int limit );

  Future<ModelEmployeesResponseRemote> getEmployees(int limit );

  Future<ModelCentersResponseRemote> getCenterDetails(String id);

  Future<ModelCreateOrUpdateCenterResponseRemote> updateCenter(String id , FormData formData ,String method);

  Future<ModelOrdersResponseRemote> getOrdersWithStatus(bool pagination , int limit , int page , int status);

  Future<ModelUpdateOrderStatusResponseRemote> updateOrderStatus(String id , int status);

  Future<ModelOrdersResponseRemote> getOrderDetails(String id);

  Future<ModelEmployeesResponseRemote> getEmployeeDetails(String empId);

  Future<ModelCreateOrUpdateEmployeeResponseRemote> createEmployee(FormData formData);

  Future<ModelCreateOrUpdateEmployeeResponseRemote> updateEmployee(String id , FormData formData ,String method);

  Future<ModelGetRatedOrdersResponseRemote> getRatedOrders(bool pagination , int limit , String empId , int page);

  Future<ModelOrdersResponseRemote> getAppointmentOrders(bool pagination , int limit , String empId , int page);

  Future<ModelGetHomeStatisticsResponseRemote> getHomeStatistics();

}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final HomeServiceClient _homeServiceClient;

  HomeRemoteDataSourceImpl(this._homeServiceClient);

  @override
  Future<ModelOrdersResponseRemote> getHomeOrders(bool pagination , int limit , int status) async {
    return await _homeServiceClient.getHomeOrders(pagination,limit,status);
  }

  @override
  Future<ModelCentersResponseRemote> getCenters(bool pagination , int limit , int page) async {
    return await _homeServiceClient.getCenters(pagination , limit , page);
  }

  @override
  Future<ModelCreateOrUpdateCenterResponseRemote> createCenter(FormData formData) async{
    return await _homeServiceClient.createCenter(formData);
  }

  @override
  Future<ModelServicesResponseRemote> getServices( int limit) async {
    return await _homeServiceClient.getServices(limit);
  }

  @override
  Future<ModelEmployeesResponseRemote> getEmployees( int limit) async {
    return await _homeServiceClient.getEmployees(limit);
  }

  @override
  Future<ModelCentersResponseRemote> getCenterDetails(String id) async{
    return await _homeServiceClient.getCenterDetails(id);
  }

  @override
  Future<ModelCreateOrUpdateCenterResponseRemote> updateCenter(String id, FormData formData, String method) async{
    return await _homeServiceClient.updateCenter(id,formData,method);
  }

  @override
  Future<ModelOrdersResponseRemote> getOrdersWithStatus(bool pagination , int limit , int page , int status) async {
    return await _homeServiceClient.getOrdersWithStatus(pagination , limit , page , status);
  }

  @override
  Future<ModelUpdateOrderStatusResponseRemote> updateOrderStatus(String id, int status) async{
    return await _homeServiceClient.updateOrderStatus(id , status);
  }

  @override
  Future<ModelOrdersResponseRemote> getOrderDetails(String id) async{
    return await _homeServiceClient.getOrderDetails(id);
  }

  @override
  Future<ModelEmployeesResponseRemote> getEmployeeDetails(String empId) async{
    return await _homeServiceClient.getEmployeeDetails(empId);
  }

  @override
  Future<ModelCreateOrUpdateEmployeeResponseRemote> createEmployee(FormData formData) async{
    return await _homeServiceClient.createEmployee(formData);
  }

  @override
  Future<ModelCreateOrUpdateEmployeeResponseRemote> updateEmployee(String id, FormData formData, String method) async{
    return await _homeServiceClient.updateEmployee(id,formData,method);
  }

  @override
  Future<ModelGetRatedOrdersResponseRemote> getRatedOrders(bool pagination, int limit, String empId, int page) async{
    return await _homeServiceClient.getRatedOrders(pagination , limit , empId , page);
  }

  @override
  Future<ModelOrdersResponseRemote> getAppointmentOrders(bool pagination, int limit, String empId, int page) async{
    return await _homeServiceClient.getAppointmentOrders(pagination , limit , empId , page);
  }

  @override
  Future<ModelGetHomeStatisticsResponseRemote> getHomeStatistics() async{
    return await _homeServiceClient.getHomeStatistics();
  }


}
