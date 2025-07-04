import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecowin/api/Services/api_repo.dart';
import 'package:http/http.dart' as http;

class AboutUsService {
  static const String baseUrl = ApiConstants.baseUrl;
  static Future<List<String>> fetchBrands() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }
    final response = await http.get(
      Uri.parse("${baseUrl}brands"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final List<dynamic> brands = responseData['data'];
      final List<String> brandImages =
          brands.map((brand) => brand['brand_image'] as String).toList();
      return brandImages;
    } else {
      throw Exception('Failed to load brands');
    }
  }
}
