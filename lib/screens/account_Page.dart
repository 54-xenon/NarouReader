import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        elevation: 1,
      ),
      body: const Center(
        child: Column(
          children: [
            Text("ローカルアカウント")
          ],
        ),
      ),
    );
  }
}