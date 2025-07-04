class BlogsModel {
  final int id;
  final String title;
  final String body;
  final String image;

  BlogsModel(
      {required this.id,
      required this.title,
      required this.body,
      required this.image});

  factory BlogsModel.fromJson(Map<String, dynamic> json) {
    return BlogsModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      image: json['image'],
    );
  }
}
