import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_settings.g.dart';

@JsonSerializable()
class ModelGetSettingsResponseRemote extends BaseResponse{
  @JsonKey(name: "data")
  final List<Data>? data;

  ModelGetSettingsResponseRemote ({
    this.data,
    super.status,
    super.code,
    super.message
  });

  factory ModelGetSettingsResponseRemote.fromJson(Map<String, dynamic> json) {
    return _$ModelGetSettingsResponseRemoteFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ModelGetSettingsResponseRemoteToJson(this);
  }
}

@JsonSerializable()
class Data {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "terms_user")
  final String? termsUser;
  @JsonKey(name: "privacy_user")
  final String? privacyUser;
  @JsonKey(name: "terms_vendor")
  final String? termsVendor;
  @JsonKey(name: "privacy_vendor")
  final String? privacyVendor;

  Data ({
    this.id,
    this.email,
    this.phone,
    this.termsUser,
    this.privacyUser,
    this.termsVendor,
    this.privacyVendor,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return _$DataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DataToJson(this);
  }
}


