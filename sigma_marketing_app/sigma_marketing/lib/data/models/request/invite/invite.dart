class Invite {
  int campaignId;
  List<int> users;

  Invite({
    required this.campaignId,
    required this.users,
  });

  Map<String, dynamic> toJson() {
    return {
      'campaignId': campaignId,
      'users': users,
    };
  }
}