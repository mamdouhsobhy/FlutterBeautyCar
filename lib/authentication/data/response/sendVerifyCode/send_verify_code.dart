import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'send_verify_code.g.dart';

@JsonSerializable()
class ModelSendVerifyCodeResponseRemote extends BaseResponse{
  @JsonKey(name: "data")
  final Data? data;

  ModelSendVerifyCodeResponseRemote ({
    this.data,
    super.status,
    super.code,
    super.message
  });

  factory ModelSendVerifyCodeResponseRemote.fromJson(Map<String, dynamic> json) {
    return _$ModelSendVerifyCodeResponseRemoteFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ModelSendVerifyCodeResponseRemoteToJson(this);
  }
}

@JsonSerializable()
class Data {
  @JsonKey(name: "otp")
  final int? otp;
  @JsonKey(name: "message")
  final String? message;

  Data ({
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


