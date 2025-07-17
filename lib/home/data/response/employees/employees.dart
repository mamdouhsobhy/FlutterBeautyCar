import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employees.g.dart';

@JsonSerializable()
class ModelEmployeesResponseRemote extends BaseResponse{
  @JsonKey(name: "data")
  final List<Data>? data;
  @JsonKey(name: "pagination")
  final Pagination? pagination;

  ModelEmployeesResponseRemote ({
    this.data,
    this.pagination,
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
  @JsonKey(name: "rate_employee_num")
  final int? rateEmployeeNum;
  @JsonKey(name: "rate_employee_start_num")
  final int? rateEmployeeStartNum;
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "notification_status")
  final int? notificationStatus;

  bool selected = false;
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
    this.rateEmployeeNum,
    this.rateEmployeeStartNum,
    this.status,
    this.notificationStatus,
  });

  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Data && runtimeType == other.runtimeType && id == other.id;

  factory Data.fromJson(Map<String, dynamic> json) {
    return _$DataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DataToJson(this);
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


