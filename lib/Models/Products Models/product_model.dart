class ProductModel {
  final int id;
  final int categoryId;
  final String name;
  final String price;
  final String image;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
    );
  }
}
