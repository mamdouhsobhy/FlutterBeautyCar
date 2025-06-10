// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelResetPasswordResponseRemote _$ModelResetPasswordResponseRemoteFromJson(
        Map<String, dynamic> json) =>
    ModelResetPasswordResponseRemote(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ModelResetPasswordResponseRemoteToJson(
        ModelResetPasswordResponseRemote instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      status: json['status'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
