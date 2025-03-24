import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String titleText;
  final String subtitleText;
  VoidCallback onPressed;  
  SettingsTile({
    super.key,
    required this.titleText,
    required this.subtitleText,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(titleText),
        subtitle: Text(subtitleText),
        onTap: onPressed,
    );
  }
}