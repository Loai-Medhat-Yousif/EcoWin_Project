import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecowin/api/Services/api_repo.dart';
import 'package:ecowin/api/Services/token_storage.dart';
import 'package:http/http.dart' as http;

class Signupservice {
  static const String baseUrl = ApiConstants.baseUrl;
  final Tokenstorage tokenstorage = Tokenstorage();

  Future<Map<String, dynamic>> signUp(String fullName, String email,
      String phone, String password, String passwordConfirmation) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }
    final response = await http.post(
      Uri.parse("${baseUrl}register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": fullName,
        "email": email,
        "phone": phone,
        "password": password,
        "password_confirmation": passwordConfirmation
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      await tokenstorage.saveToken(data['token']);
      return data;
    } else {
      throw Exception("Sign-up failed");
    }
  }
}
