
import 'package:beauty_car/home/data/network/home_api.dart';
import 'package:beauty_car/home/data/response/centers/centers.dart';
import 'package:beauty_car/home/data/response/createOrUpdateCenter/create_or_update_center.dart';
import 'package:beauty_car/home/data/response/employees/employees.dart';
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:beauty_car/home/data/response/services/services.dart';
import 'package:dio/dio.dart';

abstract class HomeRemoteDataSource {
  Future<ModelOrdersResponseRemote> getHomeOrders(int limit);

  Future<ModelCentersResponseRemote> getCenters(bool pagination , int limit , int page);

  Future<ModelCreateOrUpdateCenterResponseRemote> createCenter(FormData formData);

  Future<ModelServicesResponseRemote> getServices(int limit );

  Future<ModelEmployeesResponseRemote> getEmployees(int limit );

  Future<ModelCentersResponseRemote> getCenterDetails(String id);

  Future<ModelCreateOrUpdateCenterResponseRemote> updateCenter(String id , FormData formData ,String method);

}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final HomeServiceClient _homeServiceClient;

  HomeRemoteDataSourceImpl(this._homeServiceClient);

  @override
  Future<ModelOrdersResponseRemote> getHomeOrders(int limit) async {
    return await _homeServiceClient.getHomeOrders(limit);
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

}
