// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_verify_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelSendVerifyCodeResponseRemote _$ModelSendVerifyCodeResponseRemoteFromJson(
        Map<String, dynamic> json) =>
    ModelSendVerifyCodeResponseRemote(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ModelSendVerifyCodeResponseRemoteToJson(
        ModelSendVerifyCodeResponseRemote instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      otp: (json['otp'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'otp': instance.otp,
      'message': instance.message,
    };
