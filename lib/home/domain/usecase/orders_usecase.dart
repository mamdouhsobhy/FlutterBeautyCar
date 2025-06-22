
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:beauty_car/home/data/response/updateOrderStatus/update_order_status.dart';
import 'package:dartz/dartz.dart';
import '../../../app/baseUseCase/base_usecase.dart';
import '../../../app/errorHandler/failure.dart';
import '../../data/request/orders_request.dart';
import '../repository/home_repository.dart';

class OrdersUseCase implements BaseUseCase<OrdersRequest,ModelOrdersResponseRemote>{
  final HomeRepository _repository;

  OrdersUseCase(this._repository);

  @override
  Future<Either<Failure, ModelOrdersResponseRemote>> execute(OrdersRequest request) async{
    return await _repository.getOrdersWithStatus(request.pagination , request.limit , request.page , request.status);
  }

  @override
  Future<Either<Failure, ModelUpdateOrderStatusResponseRemote>> executeUpdateOrderStatus(String id , int status) async{
    return await _repository.updateOrderStatus(id , status);
  }
}

