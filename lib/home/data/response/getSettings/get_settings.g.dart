// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelGetSettingsResponseRemote _$ModelGetSettingsResponseRemoteFromJson(
        Map<String, dynamic> json) =>
    ModelGetSettingsResponseRemote(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ModelGetSettingsResponseRemoteToJson(
        ModelGetSettingsResponseRemote instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: (json['id'] as num?)?.toInt(),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      termsUser: json['terms_user'] as String?,
      privacyUser: json['privacy_user'] as String?,
      termsVendor: json['terms_vendor'] as String?,
      privacyVendor: json['privacy_vendor'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phone': instance.phone,
      'terms_user': instance.termsUser,
      'privacy_user': instance.privacyUser,
      'terms_vendor': instance.termsVendor,
      'privacy_vendor': instance.privacyVendor,
    };
