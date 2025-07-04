import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecowin/api/Services/api_repo.dart';
import 'package:ecowin/api/Services/token_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditProfileService {
  static const String baseUrl = ApiConstants.baseUrl;
  final Tokenstorage tokenstorage = Tokenstorage();

  Future<void> UpdatePicture(XFile image) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }

    try {
      final token = await tokenstorage.getToken();
      var uri = Uri.parse("${baseUrl}update_profile_image");
      var request = http.MultipartRequest("POST", uri);
      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(
        await http.MultipartFile.fromPath('image', image.path),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
      } else {
        throw Exception("Update profile image failed: ${response.body}");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }

  Future<void> UpdateProfile(
    String name,
    String email,
    String phone,
  ) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }

    try {
      final token = await tokenstorage.getToken();
      final response = await http.post(
        Uri.parse("${baseUrl}edit_profile"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "email": email,
          "name": name,
          "phone": phone,
        }),
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception("Update profile failed: ${response.body}");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }
}
