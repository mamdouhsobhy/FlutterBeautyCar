// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'centers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelCentersResponseRemote _$ModelCentersResponseRemoteFromJson(
        Map<String, dynamic> json) =>
    ModelCentersResponseRemote(
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

Map<String, dynamic> _$ModelCentersResponseRemoteToJson(
        ModelCentersResponseRemote instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'pagination': instance.pagination,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      employee: json['employee'] == null
          ? null
          : Employee.fromJson(json['employee'] as Map<String, dynamic>),
      vendor: json['vendor'] == null
          ? null
          : Vendor.fromJson(json['vendor'] as Map<String, dynamic>),
      openTime: json['open_time'] as String?,
      closeTime: json['close_time'] as String?,
      vendorId: (json['vendor_id'] as num?)?.toInt(),
      serviceIds: (json['service_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'image': instance.image,
      'employee': instance.employee,
      'vendor': instance.vendor,
      'open_time': instance.openTime,
      'close_time': instance.closeTime,
      'vendor_id': instance.vendorId,
      'service_ids': instance.serviceIds,
      'status': instance.status,
    };

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      id: (json['id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      image: json['image'] as String?,
      experiance: (json['experiance'] as num?)?.toInt(),
      ssdNum: json['ssd_num'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      status: (json['status'] as num?)?.toInt(),
      vendorId: (json['vendor_id'] as num?)?.toInt(),
      shopId: (json['shop_id'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt(),
      notificationStatus: (json['notification_status'] as num?)?.toInt(),
      imagePath: json['image_path'] as String?,
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'image': instance.image,
      'experiance': instance.experiance,
      'ssd_num': instance.ssdNum,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'status': instance.status,
      'vendor_id': instance.vendorId,
      'shop_id': instance.shopId,
      'type': instance.type,
      'notification_status': instance.notificationStatus,
      'image_path': instance.imagePath,
    };

Vendor _$VendorFromJson(Map<String, dynamic> json) => Vendor(
      id: (json['id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      image: json['image'] as String?,
      status: (json['status'] as num?)?.toInt(),
      verifiedPhone: (json['verified_phone'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt(),
      notificationStatus: (json['notification_status'] as num?)?.toInt(),
      imagePath: json['image_path'] as String?,
    );

Map<String, dynamic> _$VendorToJson(Vendor instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'image': instance.image,
      'status': instance.status,
      'verified_phone': instance.verifiedPhone,
      'type': instance.type,
      'notification_status': instance.notificationStatus,
      'image_path': instance.imagePath,
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
