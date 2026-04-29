// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/novel.dart';

class ApiService {
  static const int _pageSize = 20;

  Future<List<Novel>> fetchNovels(String keyword, {int page = 1}) async {
    final st = (page - 1) * _pageSize + 1;
    final response = await http.get(
      Uri.parse(
        'https://api.syosetu.com/novelapi/api/?out=json&lim=$_pageSize&st=$st&word=$keyword',
      ),
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
