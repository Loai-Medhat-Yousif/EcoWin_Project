class RewardsModel {
  int brandId;
  String brandname;
  String image;
  String discount;
  String price;

  RewardsModel({
    required this.brandId,
    required this.brandname,
    required this.image,
    required this.discount,
    required this.price,
  });

  factory RewardsModel.fromJson(Map<String, dynamic> json) {
    return RewardsModel(
      brandId: json['brand_id'],
      brandname: json['brand_name'],
      image: json['brand_image'],
      discount: json['discount_value'],
      price: json['price'],
    );
  }
}
