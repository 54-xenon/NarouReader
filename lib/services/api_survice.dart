// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/novel.dart';

class ApiService {
  Future<List<Novel>> fetchNovels(String keyword) async {
    final response = await http.get(
      Uri.parse('https://api.syosetu.com/novelapi/api/?out=json&word=$keyword'),
    );

    if (response.statusCode == 200) {
      // なろう小説APIのレスポンスは配列形式で返ってくるが、最初の要素はメタデータなので無視
      List jsonResponse = json.decode(response.body).sublist(1);
      return jsonResponse.map((novel) => Novel.fromJson(novel)).toList();
    } else {
      throw Exception('Failed to load novels');
    }
  }
}
