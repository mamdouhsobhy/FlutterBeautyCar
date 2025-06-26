import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_or_update_employee.g.dart';

@JsonSerializable()
class ModelCreateOrUpdateEmployeeResponseRemote extends BaseResponse{
  @JsonKey(name: "data")
  final Data? data;

  ModelCreateOrUpdateEmployeeResponseRemote ({
    this.data,
    super.status,
    super.code,
    super.message
  });

  factory ModelCreateOrUpdateEmployeeResponseRemote.fromJson(Map<String, dynamic> json) {
    return _$ModelCreateOrUpdateEmployeeResponseRemoteFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ModelCreateOrUpdateEmployeeResponseRemoteToJson(this);
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
  @JsonKey(name: "experiance")
  final String? experiance;
  @JsonKey(name: "ssd_num")
  final String? ssdNum;
  @JsonKey(name: "start_time")
  final String? startTime;
  @JsonKey(name: "end_time")
  final String? endTime;
  @JsonKey(name: "vendor_id")
  final int? vendorId;
  @JsonKey(name: "status")
  final String? status;

  Data ({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.experiance,
    this.ssdNum,
    this.startTime,
    this.endTime,
    this.vendorId,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return _$DataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DataToJson(this);
  }
}


