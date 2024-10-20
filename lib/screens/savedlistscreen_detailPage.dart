import 'package:flutter/material.dart';
import '../database/savedList_modell.dart';

class listDetailPage extends StatelessWidget {
  final Item item;
  listDetailPage({Key? key, required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('詳細ページ'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SelectableText(
              'Title: ${item.title}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SelectableText(
              'Ncode: ${item.ncode}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            SelectableText(
              'Stoey: ${item.story}',
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
