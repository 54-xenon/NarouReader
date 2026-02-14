import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:naroureader/database/savedList_helper.dart';
import 'package:naroureader/models/savedList_modell.dart';
import 'package:naroureader/providers/theme_provider.dart';
import 'package:naroureader/screens/account_Page.dart';
import 'package:naroureader/screens/detailPage.dart';
import '../models/novel.dart';
import '../services/api_survice.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  final TextEditingController _controller = TextEditingController();
  late Future<List<Novel>> futureNovels;

  void _searchNovels(String keyword) {
    setState(() {
      futureNovels = ApiService().fetchNovels(keyword);
    });
  }

  @override
  void initState() {
    super.initState();
    futureNovels = Future.value([]);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(l10n.searchTitle),
        leading: IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AccountPage()),
          ),
        ),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final themeMode = ref.watch(themeNotifierProvider);
              return IconButton(
                icon: Icon(
                  themeMode == ThemeMode.light
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                onPressed: () {
                  ref.read(themeNotifierProvider.notifier).toggleTheme();
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 188, 188, 188),
                    blurRadius: 10,
                    spreadRadius: 0.0,
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  filled: true,
                  hintText: l10n.searchHint,
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => _searchNovels(_controller.text),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: _searchNovels,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<Novel>>(
                future: futureNovels,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(l10n.searchError(snapshot.error.toString())),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text(l10n.searchNoResults));
                  }

                  final novels = snapshot.data!;
                  return ListView.builder(
                    itemCount: novels.length,
                    itemBuilder: (context, index) {
                      final novel = novels[index];
                      return Slidable(
                        endActionPane: ActionPane(
                          extentRatio: 0.5,
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              label: l10n.saveAction,
                              icon: Icons.bookmark_add,
                              backgroundColor: Colors.grey,
                              foregroundColor: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              onPressed: (context) async {
                                await dbHelper.insertItem(
                                  Item(
                                    title: novel.title,
                                    ncode: novel.ncode,
                                    story: novel.story,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(novel.title),
                          subtitle: Text(novel.writer),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(novel: novel),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
