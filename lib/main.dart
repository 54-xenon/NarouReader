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
    return MaterialApp(
      home: HomeScreen(),
      // ホーム画面を廃止して直接検索画面へ移動する
    );
  }
}


// ctl+fn+spaceで提案を表示\\\

