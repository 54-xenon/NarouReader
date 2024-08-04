import 'package:flutter/material.dart';
import 'package:naroureader/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(  //Providerの範囲をMyAppにすることで全てに適応
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Narou Redar',
      home: mainPage()
    );
  }
}

class mainPage extends StatelessWidget {
  const mainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text('なろう小説APIを使用したアプリです'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        backgroundColor: Colors.blue,
        onPressed: () {
          // 画面推移(main.dartからHomePageに移動する)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
      ),
    );
  }
}

// ctl+fn+spaceで提案を表示\\\
// 検索→小説の詳細を表示するページ作る

