import 'package:flutter/material.dart';
import 'package:naroureader/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:naroureader/views/widgets/settings_tile.dart';
import '../../providers/service_providers.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
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
                await ref.read(databaseHelperProvider).deleteAllItems();
              }
            },
          ),
        ],
      ),
    );
  }
}
