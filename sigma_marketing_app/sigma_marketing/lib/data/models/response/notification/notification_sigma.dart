import 'package:json_annotation/json_annotation.dart';

part 'notification_sigma.g.dart';

@JsonSerializable()
class NotificationSigma {
  @JsonKey(name: 'id')
  int id = 0;

  @JsonKey(name: 'created')
  DateTime created = DateTime.now();

  @JsonKey(name: 'title')
  String title = "";

  @JsonKey(name: 'message')
  String message = "";

  @JsonKey(name: 'isOpen')
  bool isOpen = false;

  @JsonKey(name: 'type')
  int type = 0;

  NotificationSigma(
      {required this.id,
        required this.created,
        required this.title,
        required this.message,
        required this.isOpen,
        required this.type});

  factory NotificationSigma.fromJson(dynamic json) => _$NotificationSigmaFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationSigmaToJson(this);
}