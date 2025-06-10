import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forget_password.g.dart';

@JsonSerializable()
class ModelForgetPasswordResponseRemote extends BaseResponse {
  @JsonKey(name: "data")
  final Data? data;

  ModelForgetPasswordResponseRemote(
      {this.data, super.status, super.code, super.message});

  factory ModelForgetPasswordResponseRemote.fromJson(
      Map<String, dynamic> json) {
    return _$ModelForgetPasswordResponseRemoteFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ModelForgetPasswordResponseRemoteToJson(this);
  }
}

@JsonSerializable()
class Data {
  @JsonKey(name: "otp")
  final int? otp;
  @JsonKey(name: "message")
  final String? message;

  Data({
    this.otp,
    this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return _$DataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DataToJson(this);
  }
}
