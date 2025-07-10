import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class ModelLoginResponseRemote extends BaseResponse{
  @JsonKey(name: "data")
  final UserData? data;
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
class UserData {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "notification_status")
  int? notificationStatus;
  @JsonKey(name: "ssd_num")
  String? ssd_num;
  @JsonKey(name: "start_time")
  String? start_time;
  @JsonKey(name: "end_time")
  String? end_time;

  UserData ({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.notificationStatus,
    this.ssd_num,
    this.start_time,
    this.end_time
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return _$UserDataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserDataToJson(this);
  }
}


