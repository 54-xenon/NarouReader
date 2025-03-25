import 'package:flutter/material.dart';
import 'package:naroureader/providers/theme_provider.dart';
import 'package:naroureader/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);  // テーマモードを監視

    return MaterialApp(
      title: 'Flutter Dark Mode',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),  // ライトテーマの定義
      darkTheme: ThemeData.dark(),  // ダークテーマの定義
      themeMode: themeMode,  // 監視したテーマモードを適用
      home: HomeScreen(),  // 最初に表示する画面
    );
  }
}
// ctl+fn+spaceで提案を表示
