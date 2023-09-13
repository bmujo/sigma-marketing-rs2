class SigmaTokenModel {
  int id = 0;
  String packageName = "";
  int amount = 0;
  double price = 0.0;
  bool isSelected = false;
  String checkoutUrl;
  String executeUrl;
  String accessToken;
  Map<String, dynamic> package;

  SigmaTokenModel(
      {required this.id,
      required this.packageName,
      required this.amount,
      required this.price,
      required this.isSelected,
      required this.checkoutUrl,
      required this.executeUrl,
      required this.accessToken,
      required this.package});
}
