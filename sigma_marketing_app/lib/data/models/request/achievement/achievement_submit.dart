class AchievementSubmit {
  int id;
  String comment;

  AchievementSubmit({
    required this.id,
    required this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'comment': comment,
    };
  }
}