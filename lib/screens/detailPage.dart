// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:naroureader/models/novel.dart';
import 'package:naroureader/models/savedList_modell.dart';
import '../database/savedList_helper.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.novel});

  final Novel novel;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.detailTitle),
        elevation: 1,
      ),

      // 追加ボタンの処理
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await dbHelper.insertItem(
            Item(
              title: widget.novel.title,
              ncode: widget.novel.ncode,
              story: widget.novel.story,
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.saveSuccess)),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SelectionArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // タイトル
              Text(
                widget.novel.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // 著者名
              Text(
                l10n.authorLabel(widget.novel.writer),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              // Nコード
              Text(
                l10n.ncodeLabel(widget.novel.ncode),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              // 大ジャンル-> 最初の形はInt型。mapで対応するカテゴリをStringで将来的には表示したい
              Text(
                "大カテゴリ: ${widget.novel.biggenre}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              // 少ジャンル
              Text(
                "カテゴリ: ${widget.novel.genre}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              // キーワード
              Text(
                "キーワード: ${widget.novel.keywords}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              // 種類
              Text(
                "種類: ${widget.novel.novelType}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              // 文字数
              Text(
                "文字数: ${widget.novel.length}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              // 所要時間
              Text(
                "読書時間: ${widget.novel.time}分",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              
              // 創業評価ポイント
              Text(
                "創業評価ポインt: ${widget.novel.globalPoint}pt",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              //ブックマーク数
              Text(
                "ブックマーク数: ${widget.novel.favNovelCunt}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              // 初回掲載日
              Text(
                "初回掲載日${widget.novel.generalFirstup}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              
              // 最終掲載日
              Text(
                "最終掲載日${widget.novel.generalLastup}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              
              const Divider(),
              // story
              Text(
                widget.novel.story,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
