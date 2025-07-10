import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_notification.g.dart';

@JsonSerializable()
class ModelGetNotificationResponseRemote extends BaseResponse {
  @JsonKey(name: "unread_notifications_count")
  final int? unreadNotificationsCount;

  @JsonKey(name: "data")
  final Data? data;

  ModelGetNotificationResponseRemote({
    this.unreadNotificationsCount,
    this.data,
    super.status,
    super.code,
    super.message,
  });

  factory ModelGetNotificationResponseRemote.fromJson(Map<String, dynamic> json) =>
      _$ModelGetNotificationResponseRemoteFromJson(json);

  Map<String, dynamic> toJson() => _$ModelGetNotificationResponseRemoteToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "data")
  final List<NotifyData>? data;

  @JsonKey(name: "links")
  final Links? links;

  @JsonKey(name: "meta")
  final Meta? meta;

  Data({this.data, this.links, this.meta});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class NotifyData {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "title")
  final String? title;

  @JsonKey(name: "body")
  final String? body;

  @JsonKey(name: "client_id")
  final int? clientId;

  @JsonKey(name: "client_name")
  final String? clientName;

  @JsonKey(name: "client_image")
  final String? clientImage;

  @JsonKey(name: "employee_id")
  final int? employeeId;

  @JsonKey(name: "employee_name")
  final String? employeeName;

  @JsonKey(name: "employee_image")
  final String? employeeImage;

  @JsonKey(name: "vendor_id")
  final int? vendorId;

  @JsonKey(name: "vendor_name")
  final String? vendorName;

  @JsonKey(name: "vendor_image")
  final String? vendorImage;

  @JsonKey(name: "sender")
  final String? sender;

  @JsonKey(name: "read_at")
  final dynamic? readAt;

  @JsonKey(name: "date")
  final String? date;

  NotifyData({
    this.id,
    this.title,
    this.body,
    this.clientId,
    this.clientName,
    this.clientImage,
    this.employeeId,
    this.employeeName,
    this.employeeImage,
    this.vendorId,
    this.vendorName,
    this.vendorImage,
    this.sender,
    this.readAt,
    this.date,
  });

  factory NotifyData.fromJson(Map<String, dynamic> json) =>
      _$NotifyDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotifyDataToJson(this);
}

@JsonSerializable()
class Links {
  @JsonKey(name: "first")
  final String? first;

  @JsonKey(name: "last")
  final String? last;

  @JsonKey(name: "prev")
  final dynamic? prev;

  @JsonKey(name: "next")
  final dynamic? next;

  Links({this.first, this.last, this.prev, this.next});

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

@JsonSerializable()
class Meta {
  @JsonKey(name: "current_page")
  final int? currentPage;

  @JsonKey(name: "from")
  final int? from;

  @JsonKey(name: "last_page")
  final int? lastPage;

  @JsonKey(name: "links")
  final List<MetaLink>? links;

  @JsonKey(name: "path")
  final String? path;

  @JsonKey(name: "per_page")
  final int? perPage;

  @JsonKey(name: "to")
  final int? to;

  @JsonKey(name: "total")
  final int? total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

@JsonSerializable()
class MetaLink {
  @JsonKey(name: "url")
  final String? url;

  @JsonKey(name: "label")
  final String? label;

  @JsonKey(name: "active")
  final bool? active;

  MetaLink({this.url, this.label, this.active});

  factory MetaLink.fromJson(Map<String, dynamic> json) =>
      _$MetaLinkFromJson(json);

  Map<String, dynamic> toJson() => _$MetaLinkToJson(this);
}
