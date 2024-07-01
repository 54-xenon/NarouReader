import 'package:flutter/material.dart';

class screeen_view extends StatelessWidget {
  const screeen_view({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("新しいページ"),
        ),
      ),
    );
  }
}