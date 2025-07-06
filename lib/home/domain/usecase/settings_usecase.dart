
import 'package:beauty_car/authentication/data/response/login/login.dart';
import 'package:beauty_car/home/data/response/getSettings/get_settings.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../app/baseUseCase/base_usecase.dart';
import '../../../app/errorHandler/failure.dart';
import '../repository/home_repository.dart';

class SettingsUseCase implements BaseUseCase<void,ModelGetSettingsResponseRemote>{
  final HomeRepository _repository;

  SettingsUseCase(this._repository);

  @override
  Future<Either<Failure, ModelGetSettingsResponseRemote>> execute(void input) async{
    return await _repository.getSettings();
  }

  @override
  Future<Either<Failure, ModelLoginResponseRemote>> executeUpdateNotification(FormData input) async{
    return await _repository.updateNotification(input);
  }

}
