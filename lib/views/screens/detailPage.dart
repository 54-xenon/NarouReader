// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:naroureader/models/novel.dart';
import 'package:naroureader/models/savedList_modell.dart';
import '../../providers/service_providers.dart';
import '../widgets/novel_info_row.dart';

class DetailPage extends ConsumerStatefulWidget {
  const DetailPage({super.key, required this.novel});

  final Novel novel;

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {

  String _formatDate(DateTime dt) {
    return '${dt.year}年${dt.month.toString().padLeft(2, '0')}月${dt.day.toString().padLeft(2, '0')}日';
  }

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
          // DatabaseHelperをProvidersで定義したものをインスタンス化
          final messenger = ScaffoldMessenger.of(context);
          await ref.read(databaseHelperProvider).insertItem(
            Item(
              title: widget.novel.title,
              ncode: widget.novel.ncode,
              story: widget.novel.story,
              writer: widget.novel.writer,
              biggenre: widget.novel.biggenre,
              genre: widget.novel.genre,
              keywords: widget.novel.keywords,
              novelType: widget.novel.novelType,
              length: widget.novel.length,
              time: widget.novel.time,
              globalPoint: widget.novel.globalPoint,
              favNovelCunt: widget.novel.favNovelCunt,
              generalFirstup: widget.novel.generalFirstup.toIso8601String(),
              generalLastup: widget.novel.generalLastup.toIso8601String(),
            ),
          );
          messenger.showSnackBar(SnackBar(content: Text(l10n.saveSuccess)));
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

              //その他のプロパティ
              NovelInfoRow(label: '著者', value: widget.novel.writer),
              NovelInfoRow(label: 'Nコード', value: widget.novel.ncode),
              NovelInfoRow(label: '大カテゴリ', value: '${widget.novel.biggenre}'),
              NovelInfoRow(label: 'カテゴリ', value: '${widget.novel.genre}'),
              NovelInfoRow(label: 'キーワード', value: widget.novel.keywords),
              NovelInfoRow(label: '種類', value: '${widget.novel.novelType}'),
              NovelInfoRow(label: '文字数', value: '${widget.novel.length}'),
              NovelInfoRow(label: '読書時間', value: '${widget.novel.time}分'),
              NovelInfoRow(label: '総合評価ポイント', value: '${widget.novel.globalPoint}'),
              NovelInfoRow(label: '初回投稿日', value: _formatDate(widget.novel.generalFirstup)),
              NovelInfoRow(label: '最終掲載日', value: _formatDate(widget.novel.generalLastup)),

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
