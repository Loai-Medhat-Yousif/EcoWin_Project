import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecowin/api/Services/api_repo.dart';
import 'package:http/http.dart' as http;

class ResetPasswordService {
  static const String baseUrl = ApiConstants.baseUrl;

  Future<void> resetPassword(String email) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }

    try {
      final response = await http.post(
        Uri.parse("${baseUrl}send-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("OTP: ${data['otp']}");
      } else {
        throw Exception("OTP request failed");
      }
    } catch (e) {
      throw Exception("An error occurred");
    }
  }

  Future<Map<String, dynamic>> newPassword(
      String email, String password, String confirm_password) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }
    final Uri url = Uri.parse("${baseUrl}forget-password");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
          "password_confirmation": confirm_password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"error": "Failed To Create New Password"};
      }
    } catch (e) {
      return {"error": "An error occurred"};
    }
  }

  Future<Map<String, dynamic>> verifyOtp(String email, String otp) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }
    final Uri url = Uri.parse("${baseUrl}confirm_otp");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "otp": otp,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"error": "Failed to verify OTP"};
      }
    } catch (e) {
      return {"error": "An error occurred"};
    }
  }
}
