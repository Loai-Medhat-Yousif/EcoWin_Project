import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecowin/api/Services/api_repo.dart';
import 'package:ecowin/api/Services/token_storage.dart';
import 'package:ecowin/Models/Rewards%20Models/rewards_model.dart';
import 'package:http/http.dart' as http;

class Reedemrewardservice {
  static const String baseUrl = ApiConstants.baseUrl;
  final Tokenstorage tokenstorage = Tokenstorage();

  Future<List<RewardsModel>> fetchRewards() async {
    final token = await tokenstorage.getToken();
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }
    final response = await http.get(
      Uri.parse("${baseUrl}coupons"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List rewardslist = jsonData['data'];
      return rewardslist.map((json) => RewardsModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch Rewards");
    }
  }

  Future<Map<String, dynamic>> redeemReward(
      int brandId, String discount, String price) async {
    final Uri url = Uri.parse("${baseUrl}redeem_coupon");

    try {
      final token = await tokenstorage.getToken();

      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "brand_id": brandId,
          "discount_value": discount,
          "price": price,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        String code = responseData['data']?['code'];
        return {"code": code};
      } else {
        final errorResponse = jsonDecode(response.body);
        final message = errorResponse['message'] ?? 'Failed to redeem reward';
        return {"error": message};
      }
    } catch (e) {
      print("Redeem reward error");
      print(e);
      return {"error": "An unexpected error occurred"};
    }
  }
}
