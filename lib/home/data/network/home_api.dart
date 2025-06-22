import 'package:beauty_car/home/data/response/centers/centers.dart';
import 'package:beauty_car/home/data/response/createOrUpdateCenter/create_or_update_center.dart';
import 'package:beauty_car/home/data/response/employees/employees.dart';
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:beauty_car/home/data/response/services/services.dart';
import 'package:beauty_car/home/data/response/updateOrderStatus/update_order_status.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../utils/Constants.dart';

part 'home_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class HomeServiceClient {
  factory HomeServiceClient(Dio dio, {String baseUrl}) = _HomeServiceClient;

  @GET("vendor/orders")
  Future<ModelOrdersResponseRemote> getHomeOrders(
      @Query("limit") int pagination);

  @GET("vendor/shops")
  Future<ModelCentersResponseRemote> getCenters(
    @Query("pagination") bool pagination,
    @Query("limit") int limit,
    @Query("page") int page,
  );

  @MultiPart()
  @POST("vendor/shops")
  Future<ModelCreateOrUpdateCenterResponseRemote> createCenter(
      @Body() FormData formData);

  @GET("vendor/services")
  Future<ModelServicesResponseRemote> getServices(@Query("limit") int limit);

  @GET("vendor/employees")
  Future<ModelEmployeesResponseRemote> getEmployees(@Query("limit") int limit);

  @GET("vendor/shops")
  Future<ModelCentersResponseRemote> getCenterDetails(@Query("id") String id);

  @MultiPart()
  @POST("vendor/shops/{id}")
  Future<ModelCreateOrUpdateCenterResponseRemote> updateCenter(
      @Path("id") String id,
      @Body() FormData formData,
      @Query("_method") String method);

  @GET("vendor/orders")
  Future<ModelOrdersResponseRemote> getOrdersWithStatus(
    @Query("pagination") bool pagination,
    @Query("limit") int limit,
    @Query("page") int page,
    @Query("status") int status,
  );

  @POST("vendor/orders/updateStatus")
  Future<ModelUpdateOrderStatusResponseRemote> updateOrderStatus(
      @Query("order_id") String id, @Query("status") int limit);

  @GET("vendor/orders")
  Future<ModelOrdersResponseRemote> getOrderDetails(
      @Query("id") String id);

  @GET("vendor/employees")
  Future<ModelEmployeesResponseRemote> getEmployeeDetails(@Query("id") String empId);

}
