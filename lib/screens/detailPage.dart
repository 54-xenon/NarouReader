import 'package:flutter/material.dart';
import 'package:naroureader/models/novel.dart';

class Detailpage extends StatelessWidget {
  
  final Novel novel;
  Detailpage({required this.novel});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("詳細ページ"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(  //SingleChildScrollViewでListView以外でもスクロールできるようになる
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // SelectableTextでwidget内のテキストをコピーすることができる
            SelectableText(
              'Title: ${novel.title}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16,),
            SelectableText(
              'Author: ${novel.writer}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            SelectableText(
              'URL: https://ncode.syssetu.com${novel.ncode}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            SelectableText(
              'ncode: ${novel.ncode}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            SelectableText(
              'Story: ${novel.story}',
              style: TextStyle(fontSize: 18),
            ),

          ],
        ),
      ),
    );
  }
}