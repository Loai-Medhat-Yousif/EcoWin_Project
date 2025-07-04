class ProfileDataModel {
  final String name;
  final String email;
  final String phone;
  final String image;
  final int points;
  final String? lastTransactionAmount;
  final String? lastTransactiontype;

  ProfileDataModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    this.lastTransactionAmount,
    this.lastTransactiontype,
  });

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) {
    return ProfileDataModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'] ?? '',
      points: json['points'] ?? 0,
      lastTransactionAmount: json['last_transaction']?['amount'],
      lastTransactiontype: json['last_transaction']?['type'],
    );
  }
}
