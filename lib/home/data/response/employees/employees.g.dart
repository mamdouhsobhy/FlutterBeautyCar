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
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
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
      'pagination': instance.pagination,
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
      rateEmployeeNum: (json['rate_employee_num'] as num?)?.toInt(),
      rateEmployeeStartNum: (json['rate_employee_start_num'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      notificationStatus: (json['notification_status'] as num?)?.toInt(),
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
      'rate_employee_num': instance.rateEmployeeNum,
      'rate_employee_start_num': instance.rateEmployeeStartNum,
      'status': instance.status,
      'notification_status': instance.notificationStatus,
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
