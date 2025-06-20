// ignore: file_names
import 'package:flutter/material.dart';
import 'package:naroureader/models/savedList_modell.dart';
import 'package:naroureader/models/novel.dart';
import '../database/savedList_helper.dart';


class Detailpage extends StatefulWidget {
  final Novel novel;
  Detailpage({required this.novel});

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("詳細ページ"),
        elevation: 1,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          // flutter_slidableと同じDBに小説を保存する
          await dbHelper.insertItem(Item(
            title: widget.novel.title,
            ncode: widget.novel.ncode,
            story: widget.novel.story,
          ));
          if (dbHelper != null) {
            const snackbar = SnackBar(
              content: Text("正常に保存することができました"),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          } else {
            const faildMessege = SnackBar(
              content: Text("もう一度試してください"),
            );
            ScaffoldMessenger.of(context).showSnackBar(faildMessege);
          }
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        //SingleChildScrollViewでListView以外でもスクロールできるようになる
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // SelectableTextでwidget内のテキストをコピーすることができる
            SelectableText(
              widget.novel.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SelectableText(
              'Author: ${widget.novel.writer}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            SelectableText(
              'URL: https://ncode.syssetu.com${widget.novel.ncode}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            SelectableText(
              'ncode: ${widget.novel.ncode}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            SelectableText(
              'Story: ${widget.novel.story}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
