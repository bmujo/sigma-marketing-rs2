import 'package:json_annotation/json_annotation.dart';

part 'paged_list.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PagedList<T> {
  @JsonKey(name: 'items')
  List<T> items = [];

  @JsonKey(name: 'page')
  int page = 0;

  @JsonKey(name: 'pageSize')
  int pageSize = 0;

  @JsonKey(name: 'totalCount')
  int totalCount = 0;

  @JsonKey(name: 'hasNextPage')
  bool hasNextPage = false;

  @JsonKey(name: 'hasPreviousPage')
  bool hasPreviousPage = false;

  PagedList({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory PagedList.fromJson(Map<String,dynamic> json, T Function(Object? json) fromJsonT) =>
      _$PagedListFromJson<T>(json, fromJsonT);

  Map<String,dynamic> toJson(Object Function(T) toJsonT) =>
      _$PagedListToJson<T>(this, toJsonT);
}
