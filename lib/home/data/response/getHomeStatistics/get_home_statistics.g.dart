// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_home_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelGetHomeStatisticsResponseRemote
    _$ModelGetHomeStatisticsResponseRemoteFromJson(Map<String, dynamic> json) =>
        ModelGetHomeStatisticsResponseRemote(
          data: json['data'] == null
              ? null
              : Data.fromJson(json['data'] as Map<String, dynamic>),
          status: json['status'] as bool?,
          code: (json['code'] as num?)?.toInt(),
          message: json['message'] as String?,
        );

Map<String, dynamic> _$ModelGetHomeStatisticsResponseRemoteToJson(
        ModelGetHomeStatisticsResponseRemote instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      outdoorOrders: (json['outdoorOrders'] as num?)?.toInt(),
      shopOrders: (json['shopOrders'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'outdoorOrders': instance.outdoorOrders,
      'shopOrders': instance.shopOrders,
    };
