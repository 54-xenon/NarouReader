import 'package:flutter/material.dart';
import 'package:naroureader/providers/theme_provider.dart';
import 'package:naroureader/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:naroureader/screens/savedList_screen.dart';
import 'package:naroureader/screens/settings_page.dart';

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
      home: const BottomNavigation(),  // 最初に表示する画面
    );
  }
}

// ctl+fn+spaceで提案を表示


// ドロワーをアカウント表示専用にする。
// NavBarを追加して、操作性を改善させる
class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  // 各画面のリスト
  //ホーム画面 -> HomeScreen
  // 保存リスト
  static final _screens = [
    HomeScreen(),
    const savedListPage(),
    const SettingsPage(),
  ];

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        height: 70,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedIndex: _selectedIndex,
        destinations: const<Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.list),
            icon: Icon(Icons.list_outlined),
            label: 'List',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}