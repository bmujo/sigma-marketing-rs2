import 'dart:core';

class AchievementComplete {
  int id;
  String description;
  int points;
  bool isChecked;

  AchievementComplete({
    required this.id,
    required this.description,
    required this.points,
    required this.isChecked,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'points': points,
      'isChecked': isChecked,
    };
  }
}