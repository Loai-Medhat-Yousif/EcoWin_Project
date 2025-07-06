class MyOrdersModel {
  List<Order> orders;

  MyOrdersModel({required this.orders});

  factory MyOrdersModel.fromJson(Map<String, dynamic> json) {
    return MyOrdersModel(
      orders: (json['orders'] as List)
          .map((orderJson) => Order.fromJson(orderJson))
          .toList(),
    );
  }
}

class Order {
  int points;
  String status;
  List<OrderItem> orderItems;

  Order({
    required this.points,
    required this.status,
    required this.orderItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      points: json['points'],
      status: json['status'],
      orderItems: (json['order_items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
    );
  }
}

class OrderItem {
  int quantity;
  String totalPrice;
  Product product;

  OrderItem({
    required this.quantity,
    required this.totalPrice,
    required this.product,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      quantity: json['quantity'],
      totalPrice: json['total_price'].toString(),
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
  String nameEn;
  String price;
  String image;

  Product({
    required this.nameEn,
    required this.price,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      nameEn: json['name_en'],
      price: json['price'].toString(),
      image: json['image'],
    );
  }
}
