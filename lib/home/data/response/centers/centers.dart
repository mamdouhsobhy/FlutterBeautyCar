import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'centers.g.dart';

@JsonSerializable()
class ModelCentersResponseRemote extends BaseResponse{
  @JsonKey(name: "data")
  final List<Data>? data;
  @JsonKey(name: "pagination")
  final Pagination? pagination;

  ModelCentersResponseRemote ({
    this.data,
    this.pagination,
    super.status,
    super.code,
    super.message
  });

  factory ModelCentersResponseRemote.fromJson(Map<String, dynamic> json) {
    return _$ModelCentersResponseRemoteFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ModelCentersResponseRemoteToJson(this);
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
  final List<dynamic>? serviceIds;
  @JsonKey(name: "status")
  final int? status;

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Data && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
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
  final String? image;
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
  // @JsonKey(name: "firebase_token")
  // final String? firebaseToken;
  // @JsonKey(name: "otp")
  // final int? otp;
  @JsonKey(name: "type")
  final int? type;
  @JsonKey(name: "notification_status")
  final int? notificationStatus;
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
    // this.firebaseToken,
    // this.otp,
    this.type,
    this.notificationStatus,
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
  // @JsonKey(name: "firebase_token")
  // final String? firebaseToken;
  @JsonKey(name: "status")
  final int? status;
  // @JsonKey(name: "otp")
  // final int? otp;
  @JsonKey(name: "verified_phone")
  final int? verifiedPhone;
  @JsonKey(name: "type")
  final int? type;
  @JsonKey(name: "notification_status")
  final int? notificationStatus;
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
    // this.firebaseToken,
    this.status,
    // this.otp,
    this.verifiedPhone,
    this.type,
    this.notificationStatus,
    this.imagePath,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return _$VendorFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VendorToJson(this);
  }
}

@JsonSerializable()
class Pagination {
  @JsonKey(name: "total")
  final int? total;
  @JsonKey(name: "per_page")
  final int? perPage;
  @JsonKey(name: "current_page")
  final int? currentPage;
  @JsonKey(name: "last_page")
  final int? lastPage;
  @JsonKey(name: "from")
  final int? from;
  @JsonKey(name: "to")
  final int? to;

  Pagination ({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.from,
    this.to,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return _$PaginationFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PaginationToJson(this);
  }
}


