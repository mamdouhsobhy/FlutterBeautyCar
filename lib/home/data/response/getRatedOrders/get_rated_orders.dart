import 'package:beauty_car/app/baseResponse/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_rated_orders.g.dart';

@JsonSerializable()
class ModelGetRatedOrdersResponseRemote extends BaseResponse{
  @JsonKey(name: "data")
  final List<Data>? data;
  @JsonKey(name: "pagination")
  final Pagination? pagination;

  ModelGetRatedOrdersResponseRemote ({
    this.data,
    this.pagination,
    super.status,
    super.code,
    super.message
  });

  factory ModelGetRatedOrdersResponseRemote.fromJson(Map<String, dynamic> json) {
    return _$ModelGetRatedOrdersResponseRemoteFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ModelGetRatedOrdersResponseRemoteToJson(this);
  }
}

@JsonSerializable()
class Data {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "order_star_num")
  final int? orderStarNum;
  @JsonKey(name: "employee_star_num")
  final int? employeeStarNum;
  @JsonKey(name: "comment")
  final String? comment;
  @JsonKey(name: "employee_id")
  final int? employeeId;
  @JsonKey(name: "order_id")
  final int? orderId;
  @JsonKey(name: "client_id")
  final int? clientId;
  @JsonKey(name: "client_name")
  final String? clientName;
  @JsonKey(name: "client_image")
  final dynamic? clientImage;
  @JsonKey(name: "date_added")
  final String? dateAdded;

  Data ({
    this.id,
    this.orderStarNum,
    this.employeeStarNum,
    this.comment,
    this.employeeId,
    this.orderId,
    this.clientId,
    this.clientName,
    this.clientImage,
    this.dateAdded,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return _$DataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DataToJson(this);
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Data && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

@JsonSerializable()
class Pagination {
  @JsonKey(name: "total")
  final int? total;
  @JsonKey(name: "per_page")
  final int? perPage;
  @JsonKey(name: "current_page")
  final int? currentPage;
  @JsonKey(name: "last_page")
  final int? lastPage;
  @JsonKey(name: "from")
  final int? from;
  @JsonKey(name: "to")
  final int? to;

  Pagination ({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.from,
    this.to,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return _$PaginationFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PaginationToJson(this);
  }


}


