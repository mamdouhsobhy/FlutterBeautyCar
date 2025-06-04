import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class ModelLoginResponseRemote extends BaseResponse{
  @JsonKey(name: "data")
  final Data? data;
  @JsonKey(name: "token")
  final String? token;

  ModelLoginResponseRemote ({
    this.data,
    this.token,
    super.status,
    super.code,
    super.message
  });

  factory ModelLoginResponseRemote.fromJson(Map<String, dynamic> json) {
    return _$ModelLoginResponseRemoteFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ModelLoginResponseRemoteToJson(this);
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


