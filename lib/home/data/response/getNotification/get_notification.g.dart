// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelGetNotificationResponseRemote _$ModelGetNotificationResponseRemoteFromJson(
        Map<String, dynamic> json) =>
    ModelGetNotificationResponseRemote(
      unreadNotificationsCount:
          (json['unread_notifications_count'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ModelGetNotificationResponseRemoteToJson(
        ModelGetNotificationResponseRemote instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'unread_notifications_count': instance.unreadNotificationsCount,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => NotifyData.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: json['links'] == null
          ? null
          : Links.fromJson(json['links'] as Map<String, dynamic>),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'data': instance.data,
      'links': instance.links,
      'meta': instance.meta,
    };

NotifyData _$NotifyDataFromJson(Map<String, dynamic> json) => NotifyData(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      body: json['body'] as String?,
      clientId: (json['client_id'] as num?)?.toInt(),
      clientName: json['client_name'] as String?,
      clientImage: json['client_image'] as String?,
      employeeId: (json['employee_id'] as num?)?.toInt(),
      employeeName: json['employee_name'] as String?,
      employeeImage: json['employee_image'] as String?,
      vendorId: (json['vendor_id'] as num?)?.toInt(),
      vendorName: json['vendor_name'] as String?,
      vendorImage: json['vendor_image'] as String?,
      sender: json['sender'] as String?,
      readAt: json['read_at'],
      date: json['date'] as String?,
    );

Map<String, dynamic> _$NotifyDataToJson(NotifyData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'client_id': instance.clientId,
      'client_name': instance.clientName,
      'client_image': instance.clientImage,
      'employee_id': instance.employeeId,
      'employee_name': instance.employeeName,
      'employee_image': instance.employeeImage,
      'vendor_id': instance.vendorId,
      'vendor_name': instance.vendorName,
      'vendor_image': instance.vendorImage,
      'sender': instance.sender,
      'read_at': instance.readAt,
      'date': instance.date,
    };

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      first: json['first'] as String?,
      last: json['last'] as String?,
      prev: json['prev'],
      next: json['next'],
    );

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'first': instance.first,
      'last': instance.last,
      'prev': instance.prev,
      'next': instance.next,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      currentPage: (json['current_page'] as num?)?.toInt(),
      from: (json['from'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => MetaLink.fromJson(e as Map<String, dynamic>))
          .toList(),
      path: json['path'] as String?,
      perPage: (json['per_page'] as num?)?.toInt(),
      to: (json['to'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'current_page': instance.currentPage,
      'from': instance.from,
      'last_page': instance.lastPage,
      'links': instance.links,
      'path': instance.path,
      'per_page': instance.perPage,
      'to': instance.to,
      'total': instance.total,
    };

MetaLink _$MetaLinkFromJson(Map<String, dynamic> json) => MetaLink(
      url: json['url'] as String?,
      label: json['label'] as String?,
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$MetaLinkToJson(MetaLink instance) => <String, dynamic>{
      'url': instance.url,
      'label': instance.label,
      'active': instance.active,
    };
