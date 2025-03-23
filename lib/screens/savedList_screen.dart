import 'dart:async';
import 'package:flutter/material.dart';
import 'package:naroureader/database/savedList_helper.dart';
import 'package:naroureader/screens/savedlistscreen_detailPage.dart';
import '../database/savedList_modell.dart';


class savedListPage extends StatefulWidget {
  const savedListPage({super.key});

  @override
  State<savedListPage> createState() => _savedListPageState();
}

class _savedListPageState extends State<savedListPage> {
  final dbHelper = DatabaseHelper();
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();  //初期データをロード
  }

  Future<void> _loadItems() async{
    items = await dbHelper.getItems();  //データベースからアイテムを取得
    setState(() {});  // UIを更新
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('保存リスト'),
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async{
              final confirm = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('全てのデータを削除しますか？'),
                  content: const Text('are you sure you want to delete all items?'),
                  actions: [
                    TextButton(
                      child: const Text('キャンセル'),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                    TextButton(
                      child: const Text('delete'),
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  ],
                )
              );
              // ユーザーがdeleteをタプした場合の処理(turweの場合)
              if (confirm == true) {
                await dbHelper.deleteAllItems();
                (context as Element).reassemble();
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Item>>(
        future: dbHelper.getItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No items found.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return ListTile(
                  title: Text(item.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ncode: ${item.ncode}'),
                      // Text('Story: ${item.story}'),
                      // リストが見づらくなってしまうdので一旦向こうか
                    ],
                  ),
                  onTap: () async{
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => listDetailPage(item:  item),
                      )
                    );

                    if (result == true) {
                      // 削除が成功した場合、リストを再読み込みする
                      _loadItems();
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}