

import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:beauty_car/authentication/data/response/login/login.dart';
import 'package:beauty_car/home/data/data_source/home_remote_data_source.dart';
import 'package:beauty_car/home/data/response/centers/centers.dart';
import 'package:beauty_car/home/data/response/createOrUpdateCenter/create_or_update_center.dart';
import 'package:beauty_car/home/data/response/createOrUpdateEmployee/create_or_update_employee.dart';
import 'package:beauty_car/home/data/response/employees/employees.dart';
import 'package:beauty_car/home/data/response/getHomeStatistics/get_home_statistics.dart';
import 'package:beauty_car/home/data/response/getRatedOrders/get_rated_orders.dart';
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:beauty_car/home/data/response/services/services.dart';
import 'package:beauty_car/home/data/response/updateOrderStatus/update_order_status.dart';
import 'package:beauty_car/home/domain/repository/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../app/errorHandler/error_handler.dart';
import '../../../app/errorHandler/failure.dart';
import '../../../app/networkInfo/network_info.dart';

class HomeRepositoryImpl implements HomeRepository{

  final HomeRemoteDataSource _homeRemoteDataSource;
  final NetworkInfo _networkInfo;

  HomeRepositoryImpl(this._homeRemoteDataSource,this._networkInfo);

  @override
  Future<Either<Failure, ModelOrdersResponseRemote>> getHomeOrders(bool pagination , int limit , int status) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _homeRemoteDataSource.getHomeOrders(pagination,limit,status);

        if(response.status == true){
          return Right(response);
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE, response.message?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }


    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }

  }

  @override
  Future<Either<Failure, ModelCentersResponseRemote>> getCenters(bool pagination,int limit,int page) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _homeRemoteDataSource.getCenters(pagination , limit , page);

        if(response.status == true){
          return Right(response);
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE, response.message?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }


    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }

  }

  @override
  Future<Either<Failure, ModelCreateOrUpdateCenterResponseRemote>> createCenter(FormData formData) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _homeRemoteDataSource.createCenter(formData);

        if(response.status == true){
          return Right(response);
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE, response.message?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }


    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }

  }

  @override
  Future<Either<Failure, ModelServicesResponseRemote>> getServices(int limit) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _homeRemoteDataSource.getServices(limit);

        if(response.status == true){
          return Right(response);
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE, response.message?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }


    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }

  }

  @override
  Future<Either<Failure, ModelEmployeesResponseRemote>> getEmployees(int limit) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _homeRemoteDataSource.getEmployees(limit);

        if(response.status == true){
          return Right(response);
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE, response.message?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }


    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }

  }

  @override
  Future<Either<Failure, ModelCentersResponseRemote>> getCenterDetails(String id) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _homeRemoteDataSource.getCenterDetails(id);

        if(response.status == true){
          return Right(response);
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE, response.message?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }


    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }

  }

  @override
  Future<Either<Failure, ModelCreateOrUpdateCenterResponseRemote>> updateCenter(String id, FormData formData, String method) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _homeRemoteDataSource.updateCenter(id,formData,method);

        if(response.status == true){
          return Right(response);
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE, response.message?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }


    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }

  }

  @override
  Future<Either<Failure, ModelOrdersResponseRemote>> getOrdersWithStatus(bool pagination,int limit,int page,int status) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _homeRemoteDataSource.getOrdersWithStatus(pagination , limit , page,status);

        if(response.status == true){
          return Right(response);
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE, response.message?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }


    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }

  }

  @override
  Future<Either<Failure, ModelUpdateOrderStatusResponseRemote>> updateOrderStatus(String id,int status) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _homeRemoteDataSource.updateOrderStatus(id ,status);

        if(response.status == true){
          return Right(response);
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE, response.message?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }


    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }

  }

  @override
  Future<Either<Failure, ModelOrdersResponseRemote>> getOrderDetails(String id) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _homeRemoteDataSource.getOrderDetails(id);

        if(response.status == true){
          return Right(response);
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE, response.message?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }


    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }

  }

  @override
  Future<Either<Failure, ModelEmployeesResponseRemote>> getEmployeeDetails(String empId) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _homeRemoteDataSource.getEmployeeDetails(empId);

        if(response.status == true){
          return Right(response);
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE, response.message?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }


    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }

  }

  @override
  Future<Either<Failure, ModelCreateOrUpdateEmployeeResponseRemote>> createEmployee(FormData formData) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _homeRemoteDataSource.createEmployee(formData);

        if(response.status == true){
          return Right(response);
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE, response.message?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }


    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ModelCreateOrUpdateEmployeeResponseRemote>> updateEmployee(String id, FormData formData, String method) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _homeRemoteDataSource.updateEmployee(id,formData,method);

        if(response.status == true){
          return Right(response);
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE, response.message?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }


    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ModelGetRatedOrdersResponseRemote>> getRatedOrders(bool pagination,int limit , String empId,int page) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _homeRemoteDataSource.getRatedOrders(pagination , limit , empId , page);

        if(response.status == true){
          return Right(response);
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE, response.message?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }


    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }

  }

  @override
  Future<Either<Failure, ModelOrdersResponseRemote>> getAppointmentOrders(bool pagination,int limit , String empId,int page) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _homeRemoteDataSource.getAppointmentOrders(pagination , limit , empId , page);

        if(response.status == true){
          return Right(response);
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE, response.message?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }


    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }

  }

  @override
  Future<Either<Failure, ModelGetHomeStatisticsResponseRemote>> getHomeStatistics() async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _homeRemoteDataSource.getHomeStatistics();

        if(response.status == true){
          return Right(response);
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE, response.message?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }


    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }

  }

  @override
  Future<Either<Failure, ModelLoginResponseRemote>> updateProfile(FormData data) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _homeRemoteDataSource.updateProfile(data);

        if(response.status == true){
          return Right(response);
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE, response.message?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }


    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> changePassword(FormData data) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _homeRemoteDataSource.changePassword(data);

        if(response.status == true){
          return Right(response);
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE, response.message?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }


    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

}