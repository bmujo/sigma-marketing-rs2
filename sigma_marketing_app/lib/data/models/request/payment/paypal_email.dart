class PaypalEmail {
  String paypalEmail;

  PaypalEmail({
    required this.paypalEmail,
  });

  Map<String, dynamic> toJson() {
    return {
      'paypalEmail': paypalEmail,
    };
  }
}
