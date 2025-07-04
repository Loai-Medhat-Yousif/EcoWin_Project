import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import 'package:ecowin/api/Services/api_repo.dart';
import 'package:ecowin/api/Services/token_storage.dart';

class SendOrderService {
  static const String baseUrl = ApiConstants.baseUrl;
  static final Tokenstorage tokenstorage = Tokenstorage();

  Future<void> addCart(List<Map<String, dynamic>> selectedItemsList) async {
    final token = await tokenstorage.getToken();
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }
    final response = await http.post(
      Uri.parse("${baseUrl}add_to_cart"),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
      body: jsonEncode({"products": selectedItemsList}),
    );
    if (response.statusCode == 201) {
    } else {
      throw Exception("Failed to add order");
    }
  }

  Future<void> sendAdressDetails(String street, String governate, String city,
      String buildno, String phone) async {
    final token = await tokenstorage.getToken();
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }
    final response = await http.post(
      Uri.parse("${baseUrl}confirm_order"),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "governate": governate,
        "city": city,
        "street": street,
        "building_no": buildno,
        "phone": phone
      }),
    );
    if (response.statusCode == 201) {
    } else {
      throw Exception("Failed to add adress");
    }
  }
}
