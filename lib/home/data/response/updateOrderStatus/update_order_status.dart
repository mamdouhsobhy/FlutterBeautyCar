import 'package:json_annotation/json_annotation.dart';

import '../../../../app/baseResponse/base_response.dart';

part 'update_order_status.g.dart';

@JsonSerializable()
class ModelUpdateOrderStatusResponseRemote extends BaseResponse {
  @JsonKey(name: "data")
  final UpdatedOrderData? data;

  ModelUpdateOrderStatusResponseRemote({
    this.data,
    super.status,
    super.code,
    super.message,
  });

  factory ModelUpdateOrderStatusResponseRemote.fromJson(Map<String, dynamic> json) {
    return _$ModelUpdateOrderStatusResponseRemoteFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ModelUpdateOrderStatusResponseRemoteToJson(this);
  }
}

@JsonSerializable()
class UpdatedOrderData {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "created_at")
  final String? createdAt;

  @JsonKey(name: "updated_at")
  final String? updatedAt;

  @JsonKey(name: "client_id")
  final int? clientId;

  @JsonKey(name: "client_name")
  final String? clientName;

  @JsonKey(name: "client_phone")
  final String? clientPhone;

  @JsonKey(name: "client_image")
  final String? clientImage;

  @JsonKey(name: "client_image_path")
  final String? clientImagePath;

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
  final String? serviceName;

  @JsonKey(name: "shop_id")
  final int? shopId;

  @JsonKey(name: "shop_name")
  final String? shopName;

  @JsonKey(name: "shop_address")
  final String? shopAddress;

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
  final String? time;

  @JsonKey(name: "refaused_reason")
  final String? refausedReason;

  @JsonKey(name: "place_type")
  final String? placeType;

  @JsonKey(name: "status")
  final int? status;

  UpdatedOrderData({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.clientId,
    this.clientName,
    this.clientPhone,
    this.clientImage,
    this.clientImagePath,
    this.vendorId,
    this.vendorName,
    this.vendorPhone,
    this.employeeId,
    this.employeeName,
    this.employeePhone,
    this.serviceId,
    this.serviceName,
    this.shopId,
    this.shopName,
    this.shopAddress,
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
    this.refausedReason,
    this.placeType,
    this.status,
  });

  factory UpdatedOrderData.fromJson(Map<String, dynamic> json) {
    return _$UpdatedOrderDataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UpdatedOrderDataToJson(this);
  }
}
