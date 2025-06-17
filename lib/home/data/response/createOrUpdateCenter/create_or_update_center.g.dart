// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_or_update_center.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelCreateOrUpdateCenterResponseRemote
    _$ModelCreateOrUpdateCenterResponseRemoteFromJson(
            Map<String, dynamic> json) =>
        ModelCreateOrUpdateCenterResponseRemote(
          data: json['data'] == null
              ? null
              : Data.fromJson(json['data'] as Map<String, dynamic>),
          status: json['status'] as bool?,
          code: (json['code'] as num?)?.toInt(),
          message: json['message'] as String?,
        );

Map<String, dynamic> _$ModelCreateOrUpdateCenterResponseRemoteToJson(
        ModelCreateOrUpdateCenterResponseRemote instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
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
      status: json['status'] as String?,
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
      image: json['image'],
      experiance: (json['experiance'] as num?)?.toInt(),
      ssdNum: json['ssd_num'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      status: (json['status'] as num?)?.toInt(),
      vendorId: (json['vendor_id'] as num?)?.toInt(),
      shopId: (json['shop_id'] as num?)?.toInt(),
      firebaseToken: json['firebase_token'],
      otp: json['otp'],
      type: (json['type'] as num?)?.toInt(),
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
      'firebase_token': instance.firebaseToken,
      'otp': instance.otp,
      'type': instance.type,
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
      firebaseToken: json['firebase_token'],
      status: (json['status'] as num?)?.toInt(),
      otp: json['otp'] as String?,
      verifiedPhone: (json['verified_phone'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt(),
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
      'firebase_token': instance.firebaseToken,
      'status': instance.status,
      'otp': instance.otp,
      'verified_phone': instance.verifiedPhone,
      'type': instance.type,
      'image_path': instance.imagePath,
    };
