class Purchase {
  String orderId;
  String package;
  String payerId;

  Purchase(
      {required this.orderId, required this.package, required this.payerId});

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'package': package,
      'payerId': payerId,
    };
  }
}
