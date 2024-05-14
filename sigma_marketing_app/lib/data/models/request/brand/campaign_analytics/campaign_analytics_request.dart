class CampaignAnalyticsRequest {
  DateTime startDate;
  DateTime endDate;
  List<int>? statuses;
  List<int>? platforms;
  List<int>? tags;
  int page;
  int pageSize;

  CampaignAnalyticsRequest({
    required this.startDate,
    required this.endDate,
    this.statuses,
    this.platforms,
    this.tags,
    required this.page,
    required this.pageSize,
  });

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'statuses': statuses,
      'platforms': platforms,
      'tags': tags,
      'page': page,
      'pageSize': pageSize,
    };
  }
}
