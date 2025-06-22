
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:dartz/dartz.dart';
import '../../../app/baseUseCase/base_usecase.dart';
import '../../../app/errorHandler/failure.dart';
import '../../data/request/order_details_request.dart';
import '../repository/home_repository.dart';

class OrderDetailsUseCase implements BaseUseCase<OrderDetailsRequest,ModelOrdersResponseRemote>{
  final HomeRepository _repository;

  OrderDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, ModelOrdersResponseRemote>> execute(OrderDetailsRequest request) async{
    return await _repository.getOrderDetails(request.id);
  }

}

