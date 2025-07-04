class LeaderboardDataModel {
  final String name;
  final String image;
  final int points;

  LeaderboardDataModel({
    required this.name,
    required this.image,
    required this.points,
  });

  factory LeaderboardDataModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardDataModel(
      name: json['name'],
      image: json['profile_picture'],
      points: json['points'],
    );
  }
}
