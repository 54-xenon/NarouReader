import 'package:flutter/material.dart';

class savedListPage extends StatefulWidget {
  const savedListPage({super.key});

  @override
  State<savedListPage> createState() => _savedListPageState();
}

class _savedListPageState extends State<savedListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('保存リスト'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text("これは保存リストのページです"),
      ),
    );
  }
}