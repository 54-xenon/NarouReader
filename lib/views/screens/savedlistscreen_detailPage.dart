import 'package:flutter/material.dart';
import 'package:naroureader/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/service_providers.dart';
import '../../models/savedList_modell.dart';
import '../../services/date_formatter.dart';
import '../widgets/novel_info_row.dart';

class SavedListDetailPage extends ConsumerWidget {
  const SavedListDetailPage({super.key, required this.item});

  final Item item;

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
    final locale = Localizations.localeOf(context).toString();

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

              NovelInfoRow(label: l10n.writerLabel, value: item.writer),
              NovelInfoRow(label: l10n.ncodeFieldLabel, value: item.ncode),
              NovelInfoRow(label: l10n.biggenreLabel, value: '${item.biggenre}'),
              NovelInfoRow(label: l10n.genreLabel, value: '${item.genre}'),
              NovelInfoRow(label: l10n.keywordsLabel, value: item.keywords),
              NovelInfoRow(label: l10n.novelTypeLabel, value: '${item.novelType}'),
              NovelInfoRow(label: l10n.lengthLabel, value: l10n.lengthValue(item.length)),
              NovelInfoRow(label: l10n.readTimeLabel, value: l10n.readTimeValue(item.time)),
              NovelInfoRow(label: l10n.globalPointLabel, value: l10n.globalPointValue(item.globalPoint)),
              NovelInfoRow(label: l10n.firstUpLabel, value: DateFormatter.formatFromIso(item.generalFirstup, locale: locale)),
              NovelInfoRow(label: l10n.lastUpLabel, value: DateFormatter.formatFromIso(item.generalLastup, locale: locale)),

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
