import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecowin/api/Services/api_repo.dart';
import 'package:ecowin/api/Services/token_storage.dart';
import 'package:ecowin/Models/Products%20Models/category_model.dart';
import 'package:ecowin/Models/Products%20Models/product_model.dart';
import 'package:http/http.dart' as http;

class Productservice {
  static const String baseUrl = ApiConstants.baseUrl;
  static final Tokenstorage tokenstorage = Tokenstorage();

  static Future<List<CategoryModel>> fetchCategories() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }
    final token = await tokenstorage.getToken();
    final response = await http.get(
      Uri.parse("${baseUrl}categories"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<List<ProductModel>> fetchProducts({
    required int? categoryId,
    int page = 1,
    int perPage = 20,
  }) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }
    final token = await tokenstorage.getToken();
    if (categoryId == null) {
      final response = await http.get(
        Uri.parse(
          '${baseUrl}products?page=$page&perpage=$perPage',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['data'] as List)
            .map((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load products');
      }
    } else {
      final response = await http.get(
        Uri.parse(
          '${baseUrl}products?page=$page&perpage=$perPage&categoryid=$categoryId',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['data'] as List)
            .map((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load products');
      }
    }
  }
}
