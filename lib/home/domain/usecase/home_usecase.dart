
import 'package:beauty_car/home/data/response/orders/orders.dart';
import 'package:dartz/dartz.dart';
import '../../../app/baseUseCase/base_usecase.dart';
import '../../../app/errorHandler/failure.dart';
import '../repository/home_repository.dart';

class HomeUseCase implements BaseUseCase<int,ModelOrdersResponseRemote>{
  final HomeRepository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, ModelOrdersResponseRemote>> execute(int limit) async{
    return await _repository.getHomeOrders(limit);
  }

}
