
import 'package:beauty_car/authentication/data/response/register/register.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../app/errorHandler/error_handler.dart';
import '../../../app/errorHandler/failure.dart';
import '../../../app/networkInfo/network_info.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_remote_data_source.dart';


class AuthRepositoryImpl implements AuthRepository{

  final AuthRemoteDataSource _authRemoteDataSource;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl(this._authRemoteDataSource,this._networkInfo);

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

}