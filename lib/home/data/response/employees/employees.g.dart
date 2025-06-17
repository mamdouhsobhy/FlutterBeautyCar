// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employees.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelEmployeesResponseRemote _$ModelEmployeesResponseRemoteFromJson(
        Map<String, dynamic> json) =>
    ModelEmployeesResponseRemote(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ModelEmployeesResponseRemoteToJson(
        ModelEmployeesResponseRemote instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      experiance: (json['experiance'] as num?)?.toInt(),
      ssdNum: json['ssd_num'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      vendorId: (json['vendor_id'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'image': instance.image,
      'experiance': instance.experiance,
      'ssd_num': instance.ssdNum,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'vendor_id': instance.vendorId,
      'status': instance.status,
    };
