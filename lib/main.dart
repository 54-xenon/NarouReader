import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AppBar'),
          backgroundColor: Colors.blue,
        ),
        drawer: Drawer(
          child: ListView(
            children: const <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: Text('menu'),
              ),
              ListTile(
                title: Text('about us'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ctl+fn+spaceで提案を表示