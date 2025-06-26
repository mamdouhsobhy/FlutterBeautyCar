import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_home_statistics.g.dart';

@JsonSerializable()
class ModelGetHomeStatisticsResponseRemote extends BaseResponse{
  @JsonKey(name: "data")
  final Data? data;

  ModelGetHomeStatisticsResponseRemote ({
    this.data,
    super.status,
    super.code,
    super.message
  });

  factory ModelGetHomeStatisticsResponseRemote.fromJson(Map<String, dynamic> json) {
    return _$ModelGetHomeStatisticsResponseRemoteFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ModelGetHomeStatisticsResponseRemoteToJson(this);
  }
}

@JsonSerializable()
class Data {
  @JsonKey(name: "outdoorOrders")
  final int? outdoorOrders;
  @JsonKey(name: "shopOrders")
  final int? shopOrders;

  Data ({
    this.outdoorOrders,
    this.shopOrders,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return _$DataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DataToJson(this);
  }
}


