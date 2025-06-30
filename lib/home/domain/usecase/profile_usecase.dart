
import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:beauty_car/authentication/data/response/login/login.dart';
import 'package:beauty_car/home/data/response/getHomeStatistics/get_home_statistics.dart';
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../app/baseUseCase/base_usecase.dart';
import '../../../app/errorHandler/failure.dart';
import '../../data/request/home_order_request.dart';
import '../repository/home_repository.dart';

class ProfileUseCase implements BaseUseCase<FormData,ModelLoginResponseRemote>{
  final HomeRepository _repository;

  ProfileUseCase(this._repository);

  @override
  Future<Either<Failure, ModelLoginResponseRemote>> execute(FormData request) async{
    return await _repository.updateProfile(request);
  }

  @override
  Future<Either<Failure, BaseResponse>> executeChangePassword(FormData request) async{
    return await _repository.changePassword(request);
  }

}
