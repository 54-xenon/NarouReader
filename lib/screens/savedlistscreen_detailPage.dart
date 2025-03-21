import 'package:flutter/material.dart';
import '../database/savedList_modell.dart';
import '../database/savedList_helper.dart';

class listDetailPage extends StatelessWidget {
  final dbHelper = DatabaseHelper();

  listDetailPage({Key? key, required this.item}) : super(key: key);
  final Item item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('詳細ページ'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              final confim = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('このアイテムを削除しますか?'),
                  content: const Text('このアイテムは削除されます'),
                  actions: [
                    TextButton(
                      child: const Text('キャンセル'),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                    ),
                    TextButton(
                      child: const Text('削除'),
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                    )
                  ],
                ),
              );
              if (confim == true) {
                await dbHelper.deleteItem(item.ncode);
                Navigator.pop(context, true);

              }
            },
          )
        ],
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
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
