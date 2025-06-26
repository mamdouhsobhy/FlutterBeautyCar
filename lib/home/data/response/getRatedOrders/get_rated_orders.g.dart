// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_rated_orders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelGetRatedOrdersResponseRemote _$ModelGetRatedOrdersResponseRemoteFromJson(
        Map<String, dynamic> json) =>
    ModelGetRatedOrdersResponseRemote(
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

Map<String, dynamic> _$ModelGetRatedOrdersResponseRemoteToJson(
        ModelGetRatedOrdersResponseRemote instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'pagination': instance.pagination,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: (json['id'] as num?)?.toInt(),
      orderStarNum: (json['order_star_num'] as num?)?.toInt(),
      employeeStarNum: (json['employee_star_num'] as num?)?.toInt(),
      comment: json['comment'] as String?,
      employeeId: (json['employee_id'] as num?)?.toInt(),
      orderId: (json['order_id'] as num?)?.toInt(),
      clientId: (json['client_id'] as num?)?.toInt(),
      clientName: json['client_name'] as String?,
      clientImage: json['client_image'],
      dateAdded: json['date_added'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'order_star_num': instance.orderStarNum,
      'employee_star_num': instance.employeeStarNum,
      'comment': instance.comment,
      'employee_id': instance.employeeId,
      'order_id': instance.orderId,
      'client_id': instance.clientId,
      'client_name': instance.clientName,
      'client_image': instance.clientImage,
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
