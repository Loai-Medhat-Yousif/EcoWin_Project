import 'package:equatable/equatable.dart';

class Savedadressesmodel extends Equatable {
  final int id;
  final String governate;
  final String city;
  final String streetadress;
  final String buildno;
  final String phone;

  Savedadressesmodel({
    required this.id,
    required this.governate,
    required this.city,
    required this.streetadress,
    required this.buildno,
    required this.phone,
  });

  @override
  List<Object?> get props =>
      [id, governate, city, streetadress, buildno, phone];

  Savedadressesmodel copyWith({
    int? id,
    String? governate,
    String? city,
    String? streetadress,
    String? buildno,
    String? phone,
  }) {
    return Savedadressesmodel(
      id: id ?? this.id,
      governate: governate ?? this.governate,
      city: city ?? this.city,
      streetadress: streetadress ?? this.streetadress,
      buildno: buildno ?? this.buildno,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> adresscardtojson() => {
        'id': id,
        'governate': governate,
        'city': city,
        'streetadress': streetadress,
        'buildno': buildno,
        'phone': phone,
      };

  factory Savedadressesmodel.adresscardfromjson(Map<String, dynamic> json) =>
      Savedadressesmodel(
        id: json['id'],
        governate: json['governate'],
        city: json['city'],
        streetadress: json['streetadress'],
        buildno: json['buildno'],
        phone: json['phone'],
      );
}
