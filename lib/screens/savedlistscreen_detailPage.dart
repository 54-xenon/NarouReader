import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../database/savedList_helper.dart';
import '../models/savedList_modell.dart';

class SavedListDetailPage extends StatelessWidget {
  SavedListDetailPage({super.key, required this.item});

  final dbHelper = DatabaseHelper();
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
  Widget build(BuildContext context) {
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
                await dbHelper.deleteItem(item.ncode);
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
        child: const Icon(Icons.share_rounded),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SelectableText(
              item.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SelectableText(
              l10n.ncodeLabel(item.ncode),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Divider(),
            SelectableText(
              item.story,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
