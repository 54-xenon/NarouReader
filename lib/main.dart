import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AppBar'),
          backgroundColor: Colors.blue,
        ),
        floatingActionButton: FloatingActionButton(
          Icon: Icon(Icons.search)
        ),
      ),
    );
  }
}

// ctl+fn+spaceで提案を表示