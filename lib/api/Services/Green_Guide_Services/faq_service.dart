import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecowin/api/Services/api_repo.dart';
import 'package:ecowin/api/Services/token_storage.dart';
import 'package:ecowin/Models/Q&A%20Models/q&a_model.dart';
import 'package:http/http.dart' as http;

class QuestionAndAnswerService {
  final Tokenstorage tokenstorage = Tokenstorage();
  static const String baseUrl = ApiConstants.baseUrl;

  Future<List<QuestionAndAnswerModel>> fetchQuestions(int page) async {
    final token = await tokenstorage.getToken();
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }
    final response = await http.get(
      Uri.parse("${baseUrl}questions?perpage=5&page=$page"),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List questionsandanswers = jsonData['data'];
      return questionsandanswers
          .map((json) => QuestionAndAnswerModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to fetch Questions&Answers");
    }
  }

  Future<List<QuestionAndAnswerModel>> searchQuestions(
      String question, int searchpage) async {
    final token = await tokenstorage.getToken();
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }
    final response = await http.get(
      Uri.parse(
          "${baseUrl}questions?search=$question&perpage=5&page=$searchpage"),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List questionsandanswers = jsonData['data'];
      return questionsandanswers
          .map((json) => QuestionAndAnswerModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to fetch Questions&Answers");
    }
  }
}
