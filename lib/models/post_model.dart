import 'dart:convert';
import 'package:http/http.dart' as http;

// モデルクラス
class Post {
  final String title;
  final String ncode;
  final int userid;
  final String writer;
  final String story;
  final List<String> keyword;

  Post({
    required this.title,
    required this.ncode,
    required this.userid,
    required this.writer,
    required this.story,
    required this.keyword
  });

  factory Post.fromModel(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      ncode: json['ncode'],
      userid: json['userid'],
      writer: json['writer'],
      story: json['story'],
      keyword: json['keyword'].split(' '),
    );
  }
}