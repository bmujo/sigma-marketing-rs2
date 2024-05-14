import 'package:json_annotation/json_annotation.dart';

part 'dropdown_item.g.dart';

@JsonSerializable()
class DropdownItem {
  @JsonKey(name: 'id')
  int id = 0;

  @JsonKey(name: 'name')
  String name = "";

  DropdownItem({
    required this.id,
    required this.name,
  });

  factory DropdownItem.fromJson(dynamic json) => _$DropdownItemFromJson(json);

  Map<String, dynamic> toJson() => _$DropdownItemToJson(this);
}
