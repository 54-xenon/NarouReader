import 'package:flutter/material.dart';


class Detailpage extends StatelessWidget {
  const Detailpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // MaterialAppで返すと戻るボタンが表示され無いから直接scaffoldにする
      appBar: AppBar(
        title: const Text('新しいページ'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}