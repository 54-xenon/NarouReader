import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:naroureader/database/savedList_helper.dart';
import 'package:naroureader/screens/savedlistscreen_detailPage.dart';
import '../models/savedList_modell.dart';

class SavedListPage extends StatefulWidget {
  const SavedListPage({super.key});

  @override
  State<SavedListPage> createState() => _SavedListPageState();
}

class _SavedListPageState extends State<SavedListPage> {
  final dbHelper = DatabaseHelper();

  Future<void> _loadItems() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.savedListTitle),
        elevation: 1,
      ),
      body: FutureBuilder<List<Item>>(
        future: dbHelper.getItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(l10n.savedListError(snapshot.error.toString())),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(l10n.savedListEmpty));
          }

          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final item = snapshot.data![index];
              return ListTile(
                title: Text(item.title),
                trailing: Text(item.ncode),
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SavedListDetailPage(item: item),
                    ),
                  );

                  if (result == true) {
                    _loadItems();
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
