import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecowin/api/Services/api_repo.dart';
import 'package:ecowin/api/Services/token_storage.dart';
import 'package:ecowin/Models/My_Orders%20Models/my_orders_model.dart';
import 'package:http/http.dart' as http;

class MyOrdersService {
  Future<MyOrdersModel> fetchMyOrder() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }
    const String baseUrl = ApiConstants.baseUrl;
    final Tokenstorage tokenstorage = Tokenstorage();
    final token = await tokenstorage.getToken();
    final response = await http.get(
      Uri.parse("${baseUrl}my_orders"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MyOrdersModel.fromJson(data);
    } else {
      print(response.body);
      throw Exception('Failed to load order');
    }
  }
}
