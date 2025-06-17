import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orders.g.dart';

@JsonSerializable()
class ModelOrdersResponseRemote extends BaseResponse{
  @JsonKey(name: "data")
  final List<Data>? data;
  @JsonKey(name: "pagination")
  final Pagination? pagination;

  ModelOrdersResponseRemote ({
    this.data,
    this.pagination,
    super.status,
    super.code,
    super.message
  });

  factory ModelOrdersResponseRemote.fromJson(Map<String, dynamic> json) {
    return _$ModelOrdersResponseRemoteFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ModelOrdersResponseRemoteToJson(this);
  }
}

@JsonSerializable()
class Data {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "client_id")
  final int? clientId;
  @JsonKey(name: "client_name")
  final String? clientName;
  @JsonKey(name: "client_phone")
  final String? clientPhone;
  @JsonKey(name: "shop_id")
  final int? shopId;
  @JsonKey(name: "shop_name")
  final String? shopName;
  @JsonKey(name: "shop_address")
  final String? shopAddress;
  @JsonKey(name: "vendor_id")
  final int? vendorId;
  @JsonKey(name: "vendor_name")
  final String? vendorName;
  @JsonKey(name: "vendor_phone")
  final String? vendorPhone;
  @JsonKey(name: "employee_id")
  final int? employeeId;
  @JsonKey(name: "employee_name")
  final String? employeeName;
  @JsonKey(name: "employee_phone")
  final String? employeePhone;
  @JsonKey(name: "service_id")
  final int? serviceId;
  @JsonKey(name: "service_name")
  final dynamic? serviceName;
  @JsonKey(name: "address_id")
  final int? addressId;
  @JsonKey(name: "address_name")
  final String? addressName;
  @JsonKey(name: "address_city")
  final String? addressCity;
  @JsonKey(name: "address_phone")
  final String? addressPhone;
  @JsonKey(name: "car_id")
  final int? carId;
  @JsonKey(name: "car_brand")
  final String? carBrand;
  @JsonKey(name: "car_model")
  final String? carModel;
  @JsonKey(name: "car_color")
  final String? carColor;
  @JsonKey(name: "date")
  final String? date;
  @JsonKey(name: "time")
  final dynamic? time;
  @JsonKey(name: "place_type")
  final String? placeType;
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "date_added")
  final String? dateAdded;

  Data ({
    this.id,
    this.clientId,
    this.clientName,
    this.clientPhone,
    this.shopId,
    this.shopName,
    this.shopAddress,
    this.vendorId,
    this.vendorName,
    this.vendorPhone,
    this.employeeId,
    this.employeeName,
    this.employeePhone,
    this.serviceId,
    this.serviceName,
    this.addressId,
    this.addressName,
    this.addressCity,
    this.addressPhone,
    this.carId,
    this.carBrand,
    this.carModel,
    this.carColor,
    this.date,
    this.time,
    this.placeType,
    this.status,
    this.dateAdded,
  });

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


