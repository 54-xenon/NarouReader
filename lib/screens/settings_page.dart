import 'package:flutter/material.dart';
import 'package:naroureader/util/settings_tile.dart';
import '../database/savedList_helper.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final dbHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("設定"),
        elevation: 1,
      ),
      body: ListView(
        children: [
          SettingsTile(
            titleText: "全てのデータを削除",
            subtitleText: "保存リストないのデータを全て削除します。削除されたデータを元に戻すことはできません",
            onPressed: () async{
              final confim = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("全てのデータを削除しますか？"),
                  content: const Text("保存した全てのデータが削除されます。"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text("Ok"),
                    )
                  ],
                )
              );
              if (confim == true) {
                await dbHelper.deleteAllItems();
                
              }
            },
          ),
          SettingsTile(
            titleText: "チュートリアルを表示",
            subtitleText: "使い方と新機能の説明",
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
