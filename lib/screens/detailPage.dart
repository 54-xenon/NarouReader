import 'package:flutter/material.dart';


class Detailpage extends StatelessWidget {
  const Detailpage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("新しいページ"),
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: true,
        ),
      ),
    );
  }
}