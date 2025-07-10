// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelOrdersResponseRemote _$ModelOrdersResponseRemoteFromJson(
        Map<String, dynamic> json) =>
    ModelOrdersResponseRemote(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ModelOrdersResponseRemoteToJson(
        ModelOrdersResponseRemote instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'pagination': instance.pagination,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: (json['id'] as num?)?.toInt(),
      clientId: (json['client_id'] as num?)?.toInt(),
      clientName: json['client_name'] as String?,
      clientPhone: json['client_phone'] as String?,
      client_image_path: json['client_image_path'] as String?,
      shopId: (json['shop_id'] as num?)?.toInt(),
      shopName: json['shop_name'] as String?,
      shopAddress: json['shop_address'] as String?,
      vendorId: (json['vendor_id'] as num?)?.toInt(),
      vendorName: json['vendor_name'] as String?,
      vendorPhone: json['vendor_phone'] as String?,
      employeeId: (json['employee_id'] as num?)?.toInt(),
      employeeName: json['employee_name'] as String?,
      employeePhone: json['employee_phone'] as String?,
      serviceId: (json['service_id'] as num?)?.toInt(),
      serviceName: json['service_name'] as String?,
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
      status: (json['status'] as num?)?.toInt(),
      dateAdded: json['date_added'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'client_id': instance.clientId,
      'client_name': instance.clientName,
      'client_phone': instance.clientPhone,
      'client_image_path': instance.client_image_path,
      'shop_id': instance.shopId,
      'shop_name': instance.shopName,
      'shop_address': instance.shopAddress,
      'vendor_id': instance.vendorId,
      'vendor_name': instance.vendorName,
      'vendor_phone': instance.vendorPhone,
      'employee_id': instance.employeeId,
      'employee_name': instance.employeeName,
      'employee_phone': instance.employeePhone,
      'service_id': instance.serviceId,
      'service_name': instance.serviceName,
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
      'date_added': instance.dateAdded,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      total: (json['total'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
      from: (json['from'] as num?)?.toInt(),
      to: (json['to'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'from': instance.from,
      'to': instance.to,
    };
