// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_order_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelUpdateOrderStatusResponseRemote
    _$ModelUpdateOrderStatusResponseRemoteFromJson(Map<String, dynamic> json) =>
        ModelUpdateOrderStatusResponseRemote(
          data: json['data'] == null
              ? null
              : UpdatedOrderData.fromJson(json['data'] as Map<String, dynamic>),
          status: json['status'] as bool?,
          code: (json['code'] as num?)?.toInt(),
          message: json['message'] as String?,
        );

Map<String, dynamic> _$ModelUpdateOrderStatusResponseRemoteToJson(
        ModelUpdateOrderStatusResponseRemote instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

UpdatedOrderData _$UpdatedOrderDataFromJson(Map<String, dynamic> json) =>
    UpdatedOrderData(
      id: (json['id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      clientId: (json['client_id'] as num?)?.toInt(),
      clientName: json['client_name'] as String?,
      clientPhone: json['client_phone'] as String?,
      vendorId: (json['vendor_id'] as num?)?.toInt(),
      vendorName: json['vendor_name'] as String?,
      vendorPhone: json['vendor_phone'] as String?,
      employeeId: (json['employee_id'] as num?)?.toInt(),
      employeeName: json['employee_name'] as String?,
      employeePhone: json['employee_phone'] as String?,
      serviceId: (json['service_id'] as num?)?.toInt(),
      serviceName: json['service_name'],
      shopId: (json['shop_id'] as num?)?.toInt(),
      shopName: json['shop_name'] as String?,
      shopAddress: json['shop_address'] as String?,
      addressId: (json['address_id'] as num?)?.toInt(),
      addressName: json['address_name'] as String?,
      addressCity: json['address_city'] as String?,
      addressPhone: json['address_phone'] as String?,
      carId: (json['car_id'] as num?)?.toInt(),
      carBrand: json['car_brand'] as String?,
      carModel: json['car_model'] as String?,
      carColor: json['car_color'] as String?,
      date: json['date'] as String?,
      time: json['time'],
      placeType: json['place_type'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$UpdatedOrderDataToJson(UpdatedOrderData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'client_id': instance.clientId,
      'client_name': instance.clientName,
      'client_phone': instance.clientPhone,
      'vendor_id': instance.vendorId,
      'vendor_name': instance.vendorName,
      'vendor_phone': instance.vendorPhone,
      'employee_id': instance.employeeId,
      'employee_name': instance.employeeName,
      'employee_phone': instance.employeePhone,
      'service_id': instance.serviceId,
      'service_name': instance.serviceName,
      'shop_id': instance.shopId,
      'shop_name': instance.shopName,
      'shop_address': instance.shopAddress,
      'address_id': instance.addressId,
      'address_name': instance.addressName,
      'address_city': instance.addressCity,
      'address_phone': instance.addressPhone,
      'car_id': instance.carId,
      'car_brand': instance.carBrand,
      'car_model': instance.carModel,
      'car_color': instance.carColor,
      'date': instance.date,
      'time': instance.time,
      'place_type': instance.placeType,
      'status': instance.status,
    };
