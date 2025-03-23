import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:naroureader/models/savedList_modell.dart';
import 'package:naroureader/database/savedList_helper.dart';
import 'package:naroureader/providers/theme_provider.dart';
import 'package:naroureader/screens/detailPage.dart';
import 'package:naroureader/screens/savedList_screen.dart';
import 'package:naroureader/screens/settings_page.dart';
import '../models/novel.dart';
import '../services/api_survice.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  final TextEditingController _controller = TextEditingController();
  late Future<List<Novel>> futureNovels;

  void _searchNovels(String keyword) {
    setState(() {
      futureNovels = ApiService().fetchNovels(keyword);
    });
  }

  @override
  void initState() {
    super.initState();
    futureNovels = Future.value([]); // 初期状態では空のリスト
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('検索'),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final themeMode = ref.watch(themeNotifierProvider) ?? ThemeMode.light; // ここでnull対策
              return IconButton(  // return を追加
                icon: Icon(themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
                onPressed: () {
                  try {
                    ref.read(themeNotifierProvider.notifier).toggleTheme();
                  } catch (a) {
                    print('Error');
                    throw Exception('theme toggle failed');
                  }
                },
              );
            },
          )
        ],
      ),
      // サードバー
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('保存リスト'),
              onTap: () {
                // savedList_screenに飛ぶ
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => savedListPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("設定"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
              },
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'キーワードを入力',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _searchNovels(_controller.text);
                  },
                ),
              ),
              onSubmitted: _searchNovels,
            ),
            Expanded(
              child: FutureBuilder<List<Novel>>(
                future: futureNovels,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('エラーが発生しました: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('検索結果がありません'));
                  } else {
                    List<Novel> novels = snapshot.data!;
                    return ListView.builder(
                      itemCount: novels.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          // iOS風のスライダー
                          endActionPane: ActionPane(
                            extentRatio: 0.5,
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                label: 'Save',
                                icon: Icons.bookmark_add,
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                onPressed: (context) async {
                                  // 新しいデータを挿入
                                  await dbHelper.insertItem(Item(
                                    title: novels[index].title,
                                    ncode: novels[index].ncode,
                                    story: novels[index].story,
                                  ));
                                },
                              )
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              novels[index].title,
                            ),
                            subtitle: Text(
                              novels[index].writer,
                            ), //タイトルを表示
                            trailing: Text(
                              novels[index].ncode,
                            ), //リストに右端にあるncodeを表示
                            onTap: () {
                              // 詳細画面に遷移する処理
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Detailpage(novel: novels[index])),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
