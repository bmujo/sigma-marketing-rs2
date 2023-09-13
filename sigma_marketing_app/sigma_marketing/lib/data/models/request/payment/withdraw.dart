class Withdraw {
  int amount;
  String paypalEmail;

  Withdraw(
      {required this.amount, required this.paypalEmail});

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'paypalEmail': paypalEmail,
    };
  }
}
