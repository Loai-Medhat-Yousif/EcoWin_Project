import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import 'package:ecowin/api/Services/api_repo.dart';
import 'package:ecowin/api/Services/token_storage.dart';

class CharityDonationService {
  static const String baseUrl = ApiConstants.baseUrl;
  static final Tokenstorage tokenstorage = Tokenstorage();

  Future<void> sendDonation(
    List<File> donationsImagesList,
    String street,
    String governate,
    String city,
    String description,
    String pieces,
    String phone,
    String buildnumber,
  ) async {
    final token = await tokenstorage.getToken();
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }
    try {
      var uri = Uri.parse("${baseUrl}donate");

      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['governate'] = governate
        ..fields['city'] = city
        ..fields['street'] = street
        ..fields['pieces'] = pieces
        ..fields['description'] = description
        ..fields['phone'] = phone
        ..fields['building_no'] = buildnumber;

      for (var i = 0; i < donationsImagesList.length; i++) {
        var file = donationsImagesList[i];
        var stream = http.ByteStream(file.openRead());
        var length = await file.length();

        var multipartFile = http.MultipartFile(
          'images[]',
          stream,
          length,
          filename: file.path.split('/').last,
        );

        request.files.add(multipartFile);
      }

      var response = await request.send();

      if (response.statusCode == 201) {
        print("Donation added successfully");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }
}
