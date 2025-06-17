import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_or_update_center.g.dart';

@JsonSerializable()
class ModelCreateOrUpdateCenterResponseRemote extends BaseResponse{
  @JsonKey(name: "data")
  final Data? data;

  ModelCreateOrUpdateCenterResponseRemote ({
    this.data,
    super.status,
    super.code,
    super.message
  });

  factory ModelCreateOrUpdateCenterResponseRemote.fromJson(Map<String, dynamic> json) {
    return _$ModelCreateOrUpdateCenterResponseRemoteFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ModelCreateOrUpdateCenterResponseRemoteToJson(this);
  }
}

@JsonSerializable()
class Data {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "address")
  final String? address;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "employee")
  final Employee? employee;
  @JsonKey(name: "vendor")
  final Vendor? vendor;
  @JsonKey(name: "open_time")
  final String? openTime;
  @JsonKey(name: "close_time")
  final String? closeTime;
  @JsonKey(name: "vendor_id")
  final int? vendorId;
  @JsonKey(name: "service_ids")
  final List<String>? serviceIds;
  @JsonKey(name: "status")
  final String? status;

  Data ({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.image,
    this.employee,
    this.vendor,
    this.openTime,
    this.closeTime,
    this.vendorId,
    this.serviceIds,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return _$DataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DataToJson(this);
  }
}

@JsonSerializable()
class Employee {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "image")
  final dynamic? image;
  @JsonKey(name: "experiance")
  final int? experiance;
  @JsonKey(name: "ssd_num")
  final String? ssdNum;
  @JsonKey(name: "start_time")
  final String? startTime;
  @JsonKey(name: "end_time")
  final String? endTime;
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "vendor_id")
  final int? vendorId;
  @JsonKey(name: "shop_id")
  final int? shopId;
  @JsonKey(name: "firebase_token")
  final dynamic? firebaseToken;
  @JsonKey(name: "otp")
  final dynamic? otp;
  @JsonKey(name: "type")
  final int? type;
  @JsonKey(name: "image_path")
  final String? imagePath;

  Employee ({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.image,
    this.experiance,
    this.ssdNum,
    this.startTime,
    this.endTime,
    this.status,
    this.vendorId,
    this.shopId,
    this.firebaseToken,
    this.otp,
    this.type,
    this.imagePath,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return _$EmployeeFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EmployeeToJson(this);
  }
}

@JsonSerializable()
class Vendor {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "firebase_token")
  final dynamic? firebaseToken;
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "otp")
  final String? otp;
  @JsonKey(name: "verified_phone")
  final int? verifiedPhone;
  @JsonKey(name: "type")
  final int? type;
  @JsonKey(name: "image_path")
  final String? imagePath;

  Vendor ({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.image,
    this.firebaseToken,
    this.status,
    this.otp,
    this.verifiedPhone,
    this.type,
    this.imagePath,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return _$VendorFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VendorToJson(this);
  }
}


