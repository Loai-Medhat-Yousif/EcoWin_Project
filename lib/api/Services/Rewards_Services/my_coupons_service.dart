import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecowin/api/Services/api_repo.dart';
import 'package:ecowin/api/Services/token_storage.dart';
import 'package:ecowin/Models/Rewards%20Models/my_coupons_model.dart';
import 'package:http/http.dart' as http;

class MyCouponsService {
  static const String baseUrl = ApiConstants.baseUrl;
  final Tokenstorage tokenstorage = Tokenstorage();

  Future<List<MyCouponsModel>> fetchmyCoupons() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }
    final token = await tokenstorage.getToken();

    final response = await http.get(
      Uri.parse("${baseUrl}my_coupons"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List mycouponslist = jsonData['data'];
      return mycouponslist
          .map((json) => MyCouponsModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to fetch Rewards");
    }
  }
}
