
import 'package:beauty_car/authentication/data/response/forgetPassword/forget_password.dart';
import 'package:beauty_car/authentication/data/response/login/login.dart';
import 'package:beauty_car/authentication/data/response/register/register.dart';
import 'package:beauty_car/authentication/data/response/resetPassword/reset_password.dart';
import 'package:beauty_car/authentication/data/response/sendVerifyCode/send_verify_code.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../app/errorHandler/error_handler.dart';
import '../../../app/errorHandler/failure.dart';
import '../../../app/networkInfo/network_info.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_remote_data_source.dart';
import '../response/verifyAccount/verify_account.dart';


class AuthRepositoryImpl implements AuthRepository{

  final AuthRemoteDataSource _authRemoteDataSource;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl(this._authRemoteDataSource,this._networkInfo);

  @override
  Future<Either<Failure, ModelLoginResponseRemote>> login(FormData formData) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _authRemoteDataSource.login(formData);

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
  Future<Either<Failure, ModelRegisterResponseRemote>> register(FormData formData) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _authRemoteDataSource.register(formData);

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
  Future<Either<Failure, ModelVerifyAccountResponseRemote>> verifyAccount(FormData formData) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _authRemoteDataSource.verifyAccount(formData);

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
  Future<Either<Failure, ModelSendVerifyCodeResponseRemote>> sendVerifyCode(FormData formData) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _authRemoteDataSource.sendVerifyCode(formData);

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
  Future<Either<Failure, ModelForgetPasswordResponseRemote>> forgetPassword(FormData formData) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _authRemoteDataSource.forgetPassword(formData);

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
  Future<Either<Failure, ModelResetPasswordResponseRemote>> resetPassword(FormData formData) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _authRemoteDataSource.resetPassword(formData);

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