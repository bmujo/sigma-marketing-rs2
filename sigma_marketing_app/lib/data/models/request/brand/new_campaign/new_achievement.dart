class NewAchievement {
  String title;
  String description;
  int type;
  int achievementTypeId;

  NewAchievement({
    required this.title,
    required this.description,
    required this.type,
    required this.achievementTypeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'type': type,
      'achievementTypeId': achievementTypeId,
    };
  }
}
