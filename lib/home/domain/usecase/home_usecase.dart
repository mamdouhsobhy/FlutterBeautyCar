
import 'package:beauty_car/home/data/response/getHomeStatistics/get_home_statistics.dart';
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:dartz/dartz.dart';
import '../../../app/baseUseCase/base_usecase.dart';
import '../../../app/errorHandler/failure.dart';
import '../../data/request/home_order_request.dart';
import '../repository/home_repository.dart';

class HomeUseCase implements BaseUseCase<HomeOrderRequest,ModelOrdersResponseRemote>{
  final HomeRepository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, ModelOrdersResponseRemote>> execute(HomeOrderRequest request) async{
    return await _repository.getHomeOrders(request.pagination,request.limit,request.page,request.status);
  }

  @override
  Future<Either<Failure, ModelGetHomeStatisticsResponseRemote>> executeHomeStatistics() async{
    return await _repository.getHomeStatistics();
  }

}
