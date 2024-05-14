class Transfer {
  int influencerId;
  int campaignId;

  Transfer({
    required this.influencerId,
    required this.campaignId,
  });

  Map<String, dynamic> toJson() {
    return {
      'influencerId': influencerId,
      'campaignId': campaignId,
    };
  }
}
