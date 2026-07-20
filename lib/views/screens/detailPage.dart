// ignore: file_names
import 'package:flutter/material.dart';
import 'package:naroureader/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:naroureader/models/novel.dart';
import 'package:naroureader/models/savedList_modell.dart';
import '../../providers/service_providers.dart';
import '../../services/date_formatter.dart';
import '../widgets/novel_info_row.dart';

class DetailPage extends ConsumerStatefulWidget {
  const DetailPage({super.key, required this.novel});

  final Novel novel;

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();

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
              NovelInfoRow(label: l10n.writerLabel, value: widget.novel.writer),
              NovelInfoRow(label: l10n.ncodeFieldLabel, value: widget.novel.ncode),
              NovelInfoRow(label: l10n.biggenreLabel, value: '${widget.novel.biggenre}'),
              NovelInfoRow(label: l10n.genreLabel, value: '${widget.novel.genre}'),
              NovelInfoRow(label: l10n.keywordsLabel, value: widget.novel.keywords),
              NovelInfoRow(label: l10n.novelTypeLabel, value: '${widget.novel.novelType}'),
              NovelInfoRow(label: l10n.lengthLabel, value: l10n.lengthValue(widget.novel.length)),
              NovelInfoRow(label: l10n.readTimeLabel, value: l10n.readTimeValue(widget.novel.time)),
              NovelInfoRow(label: l10n.globalPointLabel, value: l10n.globalPointValue(widget.novel.globalPoint)),
              NovelInfoRow(label: l10n.favNovelCuntLabel, value: '${widget.novel.favNovelCunt}'),
              NovelInfoRow(label: l10n.firstUpLabel, value: DateFormatter.format(widget.novel.generalFirstup, locale: locale)),
              NovelInfoRow(label: l10n.lastUpLabel, value: DateFormatter.format(widget.novel.generalLastup, locale: locale)),

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
