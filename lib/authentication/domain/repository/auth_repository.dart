
import 'package:beauty_car/authentication/data/response/register/register.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../app/errorHandler/failure.dart';

abstract class AuthRepository{

  Future<Either<Failure,ModelRegisterResponseRemote>> register(FormData formData);

}