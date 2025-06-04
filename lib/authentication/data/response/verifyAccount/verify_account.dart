import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_account.g.dart';

@JsonSerializable()
class ModelVerifyAccountResponseRemote extends BaseResponse{
  @JsonKey(name: "data")
  final dynamic? data;

  ModelVerifyAccountResponseRemote ({
    this.data,
    super.status,
    super.code,
    super.message
  });

  factory ModelVerifyAccountResponseRemote.fromJson(Map<String, dynamic> json) {
    return _$ModelVerifyAccountResponseRemoteFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ModelVerifyAccountResponseRemoteToJson(this);
  }
}


