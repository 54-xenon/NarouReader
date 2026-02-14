import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:naroureader/util/settings_tile.dart';
import '../database/savedList_helper.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
        elevation: 1,
      ),
      body: ListView(
        children: [
          SettingsTile(
            titleText: l10n.deleteAllTitle,
            subtitleText: l10n.deleteAllSubtitle,
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(l10n.deleteAllDialogTitle),
                  content: Text(l10n.deleteAllDialogContent),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(l10n.cancel),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(l10n.ok),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await dbHelper.deleteAllItems();
              }
            },
          ),
          SettingsTile(
            titleText: l10n.showTutorialTitle,
            subtitleText: l10n.showTutorialSubtitle,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
