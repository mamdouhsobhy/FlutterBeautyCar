
import 'package:beauty_car/authentication/data/response/login/login.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../app/baseUseCase/base_usecase.dart';
import '../../../app/errorHandler/failure.dart';
import '../repository/home_repository.dart';

class DeleteAccountUseCase implements BaseUseCase<FormData,ModelLoginResponseRemote>{
  final HomeRepository _repository;

  DeleteAccountUseCase(this._repository);

  @override
  Future<Either<Failure, ModelLoginResponseRemote>> execute(FormData request) async{
    return await _repository.deleteAccount(request);
  }

}
