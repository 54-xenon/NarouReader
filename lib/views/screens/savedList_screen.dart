import 'package:flutter/material.dart';
import 'package:naroureader/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:naroureader/providers/service_providers.dart';
import 'package:naroureader/views/screens/savedlistscreen_detailPage.dart';
import '../../models/savedList_modell.dart';

class SavedListPage extends ConsumerStatefulWidget {
  const SavedListPage({super.key});

  @override
  ConsumerState<SavedListPage> createState() => _SavedListPageState();
}

class _SavedListPageState extends ConsumerState<SavedListPage> {
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
        future: ref.read(databaseHelperProvider).getItems(),
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
