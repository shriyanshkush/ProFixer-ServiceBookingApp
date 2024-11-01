class Payment {
  final String paymentId;
  final String amount;
  final String status;
  final String timeStamp;

  Payment({
    required this.paymentId,
    required this.amount,
    required this.status,
    required this.timeStamp,
  });

  // Factory method to create a Payment instance from JSON
  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentId: json["paymentId"] as String,
      amount: json["amount"] as String,
      status: json["status"] as String,
      timeStamp: json["timeStamp"] as String,
    );
  }

  // Method to convert a Payment instance to JSON
  Map<String, dynamic> toJson() {
    return {
      "paymentId": paymentId,
      "amount": amount,
      "status": status,
      "timeStamp": timeStamp,
    };
  }
}
