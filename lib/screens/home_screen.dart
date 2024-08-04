// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:naroureader/screens/detailPage.dart';
// import 'package:naroureader/screens/AlertDialogPage.dart';
// アラートは一旦無効化する
import '../models/novel.dart';
import '../services/api_survice.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        title: const Text('小説を検索'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('エラーが発生しました: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('検索結果がありません'));
                  } else {
                    List<Novel> novels = snapshot.data!;
                    return ListView.builder(
                      itemCount: novels.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(novels[index].title),
                          subtitle: Text(novels[index].writer), //タイトルを表示
                          trailing: Text(novels[index].ncode), //リストに右端にあるncodeを表示
                          onTap: () {
                            // 詳細画面に遷移するなどの処理
                            //小説の詳細ページに飛ぶ処理
                            // showDialog(context: context, builder: (_) {
                            //   return AlertDiaLogSample();
                            // });
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Detailpage(novel: novels[index])),
                            );
                          },
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



// origin  https://github.com/54-xenon/NarouReader.git (fetch)
// origin  https://github.com/54-xenon/NarouReader.git (push)