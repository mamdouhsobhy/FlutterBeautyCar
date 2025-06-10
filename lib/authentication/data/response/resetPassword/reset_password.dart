import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password.g.dart';

@JsonSerializable()
class ModelResetPasswordResponseRemote extends BaseResponse {
  @JsonKey(name: "data")
  final Data? data;

  ModelResetPasswordResponseRemote(
      {this.data, super.status, super.code, super.message});

  factory ModelResetPasswordResponseRemote.fromJson(Map<String, dynamic> json) {
    return _$ModelResetPasswordResponseRemoteFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ModelResetPasswordResponseRemoteToJson(this);
  }
}

@JsonSerializable()
class Data {
  @JsonKey(name: "status")
  final bool? status;
  @JsonKey(name: "message")
  final String? message;

  Data({
    this.status,
    this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return _$DataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DataToJson(this);
  }
}
