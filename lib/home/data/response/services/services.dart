import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'services.g.dart';

@JsonSerializable()
class ModelServicesResponseRemote extends BaseResponse{
  @JsonKey(name: "data")
  final List<Services>? data;

  ModelServicesResponseRemote ({
    this.data,
    super.status,
    super.code,
    super.message
  });

  factory ModelServicesResponseRemote.fromJson(Map<String, dynamic> json) {
    return _$ModelServicesResponseRemoteFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ModelServicesResponseRemoteToJson(this);
  }
}

@JsonSerializable()
class Services {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(includeFromJson: false, includeToJson: true)
  bool selected = false;

  Services ({
    this.id,
    this.name,
    this.image,
  });

  factory Services.fromJson(Map<String, dynamic> json) {
    return _$ServicesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ServicesToJson(this);
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Services && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}


