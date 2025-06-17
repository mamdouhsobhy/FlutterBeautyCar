import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employees.g.dart';

@JsonSerializable()
class ModelEmployeesResponseRemote extends BaseResponse{
  @JsonKey(name: "data")
  final List<Data>? data;

  ModelEmployeesResponseRemote ({
    this.data,
    super.status,
    super.code,
    super.message
  });

  factory ModelEmployeesResponseRemote.fromJson(Map<String, dynamic> json) {
    return _$ModelEmployeesResponseRemoteFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ModelEmployeesResponseRemoteToJson(this);
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
  final int? experiance;
  @JsonKey(name: "ssd_num")
  final String? ssdNum;
  @JsonKey(name: "start_time")
  final String? startTime;
  @JsonKey(name: "end_time")
  final String? endTime;
  @JsonKey(name: "vendor_id")
  final int? vendorId;
  @JsonKey(name: "status")
  final int? status;

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


