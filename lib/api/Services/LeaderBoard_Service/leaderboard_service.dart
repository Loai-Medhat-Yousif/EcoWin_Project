import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import 'package:ecowin/api/Services/api_repo.dart';
import 'package:ecowin/api/Services/token_storage.dart';
import 'package:ecowin/Models/Profile%20Models/leaderboard_data_model.dart';

class LeaderboardService {
  final Tokenstorage tokenstorage = Tokenstorage();
  static const String baseUrl = ApiConstants.baseUrl;

  Future<List<LeaderboardDataModel>> fetchLeaderboardData() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }
    final token = await tokenstorage.getToken();
    final response = await http.get(
      Uri.parse("${baseUrl}top-users"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final responsejsonData = json.decode(response.body);
      final List<dynamic> usersList = responsejsonData['users'];
      return usersList
          .map((json) => LeaderboardDataModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to fetch leaderboard data');
    }
  }
}
