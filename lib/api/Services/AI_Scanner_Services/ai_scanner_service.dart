import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecowin/api/Services/api_repo.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ScannerService {
  static Future<String> detectMaterial(File imageFile) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception(
          'No internet connection. Please check your network and try again.');
    }
    const String aiScannerBaseUrl = ApiConstants.aiScannerBasUrl;
    var request = http.MultipartRequest('POST', Uri.parse(aiScannerBaseUrl));
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    var streamedResponse = await request.send();
    final responseBody = await streamedResponse.stream.bytesToString();
    final statusCode = streamedResponse.statusCode;
    if (statusCode == 200) {
      final data = jsonDecode(responseBody);
      return data['predicted_class'] ?? 'Unknown Material';
    }
    throw Exception('Failed to process the image');
  }
}
