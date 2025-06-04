// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelVerifyAccountResponseRemote _$ModelVerifyAccountResponseRemoteFromJson(
        Map<String, dynamic> json) =>
    ModelVerifyAccountResponseRemote(
      data: json['data'],
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ModelVerifyAccountResponseRemoteToJson(
        ModelVerifyAccountResponseRemote instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
