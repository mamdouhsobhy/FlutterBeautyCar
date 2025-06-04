import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  final bool? status;
  @JsonKey(name: "code")
  final int? code;
  @JsonKey(name: "message")
  final String? message;

  BaseResponse ({
    this.status,
    this.code,
    this.message,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return _$BaseResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BaseResponseToJson(this);
  }
}


