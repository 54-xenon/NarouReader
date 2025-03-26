import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/savedList_modell.dart';
import '../database/savedList_helper.dart';

class listDetailPage extends StatelessWidget {
  final dbHelper = DatabaseHelper();

  listDetailPage({Key? key, required this.item}) : super(key: key);
  final Item item;

   // URLを開く関数
  Future<void> _launchUrl(BuildContext context) async {
    String urlHttp = "https://ncode.syosetu.com/";
    final Uri _url = Uri.parse(urlHttp + item.ncode);

    try {
      // URLが開けるか事前チェック
      if (await canLaunchUrl(_url)) {
        await launchUrl(_url);
      } else {
        // 開けない場合はアラートを表示
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('URLを開けません: $_url'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // 例外キャッチ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('エラーが発生しました: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('詳細ページ'),
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _launchUrl(context),
        child: const Icon(Icons.share_rounded),

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SelectableText(
              item.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SelectableText(
              'Ncode: ${item.ncode}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
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
