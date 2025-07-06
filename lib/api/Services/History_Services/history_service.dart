import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecowin/api/Services/api_repo.dart';
import 'package:ecowin/api/Services/token_storage.dart';
import 'package:ecowin/Models/Transation%20Models/transaction_model.dart';
import 'package:http/http.dart' as http;

class HistoryService {
  final Tokenstorage tokenstorage = Tokenstorage();
  static const String baseUrl = ApiConstants.baseUrl;

  Future<List<TransactionModel>> fetchTransactions(int page) async {
    final token = await tokenstorage.getToken();
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception("No internet connection. Please check your network.");
    }
    final response = await http.get(
      Uri.parse("${baseUrl}transactions?page=$page"),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List transactions = jsonData['transactions'];
      return transactions
          .map((json) => TransactionModel.fromJson(json))
          .toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception("Failed to fetch transactions");
    }
  }
}
