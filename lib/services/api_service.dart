import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/path_task_model.dart';

class ApiException implements Exception {
  ApiException(this.message);
  final String message;

  @override
  String toString() => message;
}

class ApiService {
  Future<List<PathTask>> fetchTasks(Uri uri) async {
    final response = await http.get(uri);

    final body = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200 || body['error'] == true) {
      throw ApiException(body['message'] as String? ?? 'HTTP ${response.statusCode}');
    }

    final data = body['data'] as List;
    return data
        .map((item) => PathTask.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}