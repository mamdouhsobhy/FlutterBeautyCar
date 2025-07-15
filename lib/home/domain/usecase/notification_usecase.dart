
import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:beauty_car/home/data/response/getNotification/get_notification.dart';
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../app/baseUseCase/base_usecase.dart';
import '../../../app/errorHandler/failure.dart';
import '../repository/home_repository.dart';

class NotificationUseCase implements BaseUseCase<int,ModelGetNotificationResponseRemote>{
  final HomeRepository _repository;

  NotificationUseCase(this._repository);

  @override
  Future<Either<Failure, ModelGetNotificationResponseRemote>> execute(int page) async{
    return await _repository.getNotification(page);
  }

  @override
  Future<Either<Failure, BaseResponse>> executeReadNotify() async{
    return await _repository.readNotify();
  }


}
