import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register.g.dart';

@JsonSerializable()
class ModelRegisterResponseRemote extends BaseResponse{
  @JsonKey(name: "data")
  final Data? data;

  ModelRegisterResponseRemote ({
    this.data,
    super.status,
    super.code,
    super.message,
  });

  factory ModelRegisterResponseRemote.fromJson(Map<String, dynamic> json) {
    return _$ModelRegisterResponseRemoteFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ModelRegisterResponseRemoteToJson(this);
  }
}

@JsonSerializable()
class Data {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "image")
  final String? image;

  Data ({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return _$DataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DataToJson(this);
  }
}


