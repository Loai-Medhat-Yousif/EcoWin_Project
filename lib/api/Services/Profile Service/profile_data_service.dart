import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecowin/api/Services/api_repo.dart';
import 'package:ecowin/api/Services/token_storage.dart';
import 'package:ecowin/Models/Profile%20Models/profile_data_model.dart';
import 'package:http/http.dart' as http;

class ProfileDataService {
  final Tokenstorage tokenstorage = Tokenstorage();
  static const String baseUrl = ApiConstants.baseUrl;

  Future<ProfileDataModel> fetchProfileData() async {
    final token = await tokenstorage.getToken();
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }
    final response = await http.get(
      Uri.parse("${baseUrl}get_profile"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      final Map<String, dynamic> userinfo = responseJson['user'];
      return ProfileDataModel.fromJson(userinfo);
    } else {
      throw Exception("Failed to fetch profile data");
    }
  }
}
