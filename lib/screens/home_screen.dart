// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
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
        title: Text('なろう小説検索'),
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
                  icon: Icon(Icons.search),
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
                          subtitle: Text(novels[index].writer),
                          onTap: () {
                            // 詳細画面に遷移するなどの処理
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
