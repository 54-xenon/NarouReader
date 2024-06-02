import 'dart:convert';
import 'package:http/http.dart' as http;

// モデルクラス
class Novel {
  final String title;
  final String story;
  final String writer;

  Novel({
    required this.title,
    required this.story,
    required this.writer,
  });

  factory Novel.fromJson(Map<String, dynamic> json) {
    return Novel(
      title: json['title'],
      story: json['story'],
      writer: json['writer'],
    );
  }
}