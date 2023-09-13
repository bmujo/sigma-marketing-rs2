import 'package:json_annotation/json_annotation.dart';

part 'payment_terms_data.g.dart';

@JsonSerializable()
class PaymentTermsData {
  @JsonKey(name: 'id')
  int id = 0;

  @JsonKey(name: 'name')
  String name = "";

  PaymentTermsData({required this.id, required this.name});

  factory PaymentTermsData.fromJson(dynamic json) => _$PaymentTermsDataFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTermsDataToJson(this);
}