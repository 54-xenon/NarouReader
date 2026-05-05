import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/service_providers.dart';
import '../../models/savedList_modell.dart';
import '../widgets/novel_info_row.dart';

class SavedListDetailPage extends ConsumerWidget {
  const SavedListDetailPage({super.key, required this.item});

  final Item item;

  // 日付プロパティのフォーマットメソッド
  String _formatDate(String isoString) {
    final dt = DateTime.parse(isoString);
    return '${dt.year}年${dt.month.toString().padLeft(2, '0')}月${dt.day.toString().padLeft(2, '0')}日';
  }

  Future<void> _launchUrl(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final uri = Uri.parse('https://ncode.syosetu.com/${item.ncode}');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      return;
    }

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.openUrlFailed(uri.toString())),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.detailTitle),
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(l10n.savedItemDeleteConfirmTitle),
                  content: Text(l10n.savedItemDeleteConfirmContent),
                  actions: [
                    TextButton(
                      child: Text(l10n.cancel),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                    TextButton(
                      child: Text(l10n.delete),
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await ref.read(databaseHelperProvider).deleteItem(item.ncode);
                if (context.mounted) {
                  Navigator.pop(context, true);
                }
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _launchUrl(context),
        child: const Icon(Icons.open_in_browser),

      ),
      body: SelectionArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // タイトル
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              NovelInfoRow(label: '著者', value: item.writer),
              NovelInfoRow(label: 'Nコード', value: item.ncode),
              NovelInfoRow(label: '大カテゴリ', value: '${item.biggenre}'),
              NovelInfoRow(label: 'カテゴリ', value: '${item.genre}'),
              NovelInfoRow(label: 'キーワード', value: item.keywords),
              NovelInfoRow(label: '種類', value: '${item.novelType}'),
              NovelInfoRow(label: '文字数', value: '${item.length}'),
              NovelInfoRow(label: '読書時間', value: '${item.time}分'),
              NovelInfoRow(label: '総合評価ポイント', value: '${item.globalPoint}'),
              NovelInfoRow(label: '初回投稿日', value: _formatDate(item.generalFirstup)),
              NovelInfoRow(label: '最終掲載日', value: _formatDate(item.generalLastup)),

              const Divider(),
              Text(
                item.story,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
