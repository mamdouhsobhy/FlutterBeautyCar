
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:dartz/dartz.dart';
import '../../../app/baseUseCase/base_usecase.dart';
import '../../../app/errorHandler/failure.dart';
import '../../data/request/rated_orders_request.dart';
import '../repository/home_repository.dart';

class AppointmentOrdersUseCase implements BaseUseCase<RatedOrdersRequest,ModelOrdersResponseRemote>{
  final HomeRepository _repository;

  AppointmentOrdersUseCase(this._repository);

  @override
  Future<Either<Failure, ModelOrdersResponseRemote>> execute(RatedOrdersRequest request) async{
    return await _repository.getAppointmentOrders(request.pagination , request.limit , request.empId , request.page);
  }

}

