// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.accountTitle),
        elevation: 1,
      ),
      body: Center(
        child: Column(
          children: [
            Text(l10n.localAccount),
          ],
        ),
      ),
    );
  }
}
