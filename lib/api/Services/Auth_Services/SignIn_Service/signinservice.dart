import 'dart:convert';
import 'package:ecowin/api/Services/api_repo.dart';
import 'package:ecowin/api/Services/token_storage.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class Signinservice {
  static const String baseUrl = ApiConstants.baseUrl;
  final Tokenstorage tokenstorage = Tokenstorage();

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }

    try {
      final response = await http.post(
        Uri.parse("${baseUrl}login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        await tokenstorage.saveToken(data['token']);
        return data;
      } else {
        throw Exception("Sign-In failed");
      }
    } catch (e) {
      print(e);
      throw Exception("An error occurred: $e");
    }
  }
}
