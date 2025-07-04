import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecowin/api/Services/api_repo.dart';
import 'package:ecowin/api/Services/token_storage.dart';
import 'package:ecowin/Models/Blogs%20Models/blogs_model.dart';
import 'package:http/http.dart' as http;

class BlogsService {
  final Tokenstorage tokenstorage = Tokenstorage();
  static const String baseUrl = ApiConstants.baseUrl;

  Future<List<BlogsModel>> fetchBlogs(int page) async {
    final token = await tokenstorage.getToken();
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }
    final response = await http.get(
      Uri.parse("${baseUrl}blogs?perpage=10&page=$page"),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List blogs = jsonData['data'];
      return blogs.map((json) => BlogsModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch Blogs");
    }
  }
}
