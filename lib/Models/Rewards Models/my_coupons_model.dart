class MyCouponsModel {
  int brandId;
  String brandname;
  String image;
  String discount;
  String code;

  MyCouponsModel({
    required this.brandId,
    required this.brandname,
    required this.image,
    required this.discount,
    required this.code,
  });

  factory MyCouponsModel.fromJson(Map<String, dynamic> json) {
    return MyCouponsModel(
      brandId: json['brand_id'],
      brandname: json['brand_name'],
      image: json['brand_image'],
      discount: json['discount_value'],
      code: json['code'],
    );
  }
}
