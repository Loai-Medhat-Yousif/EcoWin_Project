class TransactionModel {
  final String type;
  final String amount;
  final String date;

  TransactionModel({
    required this.type,
    required this.amount,
    required this.date,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      type: json['type'],
      amount: json['amount'],
      date: json['created_at'],
    );
  }
}
