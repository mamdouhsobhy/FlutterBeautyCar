// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelLoginResponseRemote _$ModelLoginResponseRemoteFromJson(
        Map<String, dynamic> json) =>
    ModelLoginResponseRemote(
      data: json['data'] == null
          ? null
          : UserData.fromJson(json['data'] as Map<String, dynamic>),
      token: json['token'] as String?,
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ModelLoginResponseRemoteToJson(
        ModelLoginResponseRemote instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'token': instance.token,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      notificationStatus: (json['notification_status'] as num?)?.toInt(),
      ssd_num: json['ssd_num'] as String?,
      start_time: json['start_time'] as String?,
      end_time: json['end_time'] as String?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'image': instance.image,
      'notification_status': instance.notificationStatus,
      'ssd_num': instance.ssd_num,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
    };
