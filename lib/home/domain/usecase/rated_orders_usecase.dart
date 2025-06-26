
import 'package:beauty_car/home/data/response/getRatedOrders/get_rated_orders.dart';
import 'package:dartz/dartz.dart';
import '../../../app/baseUseCase/base_usecase.dart';
import '../../../app/errorHandler/failure.dart';
import '../../data/request/rated_orders_request.dart';
import '../repository/home_repository.dart';

class RatedOrdersUseCase implements BaseUseCase<RatedOrdersRequest,ModelGetRatedOrdersResponseRemote>{
  final HomeRepository _repository;

  RatedOrdersUseCase(this._repository);

  @override
  Future<Either<Failure, ModelGetRatedOrdersResponseRemote>> execute(RatedOrdersRequest request) async{
    return await _repository.getRatedOrders(request.pagination , request.limit , request.empId , request.page);
  }

}

