import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/network/path_task_model.dart';
import '../models/network/path_check_model.dart';
import '../models/internal/path_result.dart';

class ApiException implements Exception {
  ApiException(this.message);
  final String message;

  @override
  String toString() => message;
}

class ApiService {
  Future<List<PathTask>> fetchTasks(Uri uri) async {
    final response = await http.get(uri);
    final data = _parseData(response) as List;
    return data
        .map((item) => PathTask.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<PathCheck>> sendResults(Uri uri, List<PathResult> results) async {
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(results.map((result) => result.toJson()).toList()),
    );
    final data = _parseData(response) as List;
    return data
        .map((item) => PathCheck.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Object? _parseData(http.Response response) {
    final Map<String, dynamic> body;
    try {
      body = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (_) {
      throw ApiException('Server returned an unexpected response. Check the API URL.');
    }

    final isSuccess = response.statusCode >= 200 && response.statusCode < 300;

    if (!isSuccess || body['error'] == true) {
      throw ApiException(body['message'] as String? ?? 'HTTP ${response.statusCode}');
    }
    return body['data'];
  }
}