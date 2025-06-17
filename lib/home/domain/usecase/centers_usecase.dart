
import 'package:beauty_car/home/data/request/centers_request.dart';
import 'package:beauty_car/home/data/response/centers/centers.dart';
import 'package:dartz/dartz.dart';
import '../../../app/baseUseCase/base_usecase.dart';
import '../../../app/errorHandler/failure.dart';
import '../repository/home_repository.dart';

class CentersUseCase implements BaseUseCase<CentersRequest,ModelCentersResponseRemote>{
  final HomeRepository _repository;

  CentersUseCase(this._repository);

  @override
  Future<Either<Failure, ModelCentersResponseRemote>> execute(CentersRequest centerRequest) async{
    return await _repository.getCenters(centerRequest.pagination,centerRequest.limit,centerRequest.page);
  }

}

