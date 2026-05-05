import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/service_providers.dart';
import '../../models/savedList_modell.dart';

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

              // 著者名
              Text(
                "著者: ${item.writer}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              // Nコード
              Text(
                l10n.ncodeLabel(item.ncode),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              // 大ジャンル
              Text(
                "大カテゴリ: ${item.biggenre}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              // ジャンル
              Text(
                "カテゴリ: ${item.genre}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 18),

              // キーワード
              Text(
                "キーワード: ${item.keywords}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              // 種類
              Text(
                "種類: ${item.novelType}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              // 文字数
              Text(
                "文字数: ${item.length}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              // 所要時間
              Text(
                "読書時間: ${item.time}分",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              // 創業評価ポイント
              Text(
                "総合評価ポイント: ${item.globalPoint}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              // 初回投稿日
              Text(
                "初回投稿日: ${_formatDate(item.generalFirstup)}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              // 最終掲載日
              Text(
                "最終掲載日: ${_formatDate(item.generalLastup)}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),

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
