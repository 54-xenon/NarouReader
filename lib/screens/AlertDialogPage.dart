import 'package:flutter/material.dart';

class AlertDiaLogSample extends StatelessWidget {
  const AlertDiaLogSample({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("この機能はまだ利用できません"),
      // タップでアラートを表示させる
      actions: <Widget>[
        GestureDetector(
          child: Text("戻る"),
          onTap: () {
            Navigator.pop(context);
          },
        )
      ],

    );
  }
}

