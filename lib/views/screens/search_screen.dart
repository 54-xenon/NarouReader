import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:naroureader/models/savedList_modell.dart';
import 'package:naroureader/providers/service_providers.dart';
import 'package:naroureader/providers/theme_provider.dart';
import 'package:naroureader/views/screens/detailPage.dart';
import 'package:naroureader/viewmodels/search_viewmodel.dart';

class SearchScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(searchViewModelProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final searchState = ref.watch(searchViewModelProvider);

    // エラーメッセージをSnackBarで表示
    ref.listen(searchViewModelProvider, (prev, next) {
      if (next.errorMessage != null && next.errorMessage != prev?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage!)),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(l10n.searchTitle),
        actions: [
          IconButton(
            icon: Icon(
              ref.watch(themeNotifierProvider) == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              ref.read(themeNotifierProvider.notifier).toggleTheme();
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
                    onPressed: () => ref
                        .read(searchViewModelProvider.notifier)
                        .search(_controller.text),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (keyword) =>
                    ref.read(searchViewModelProvider.notifier).search(keyword),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: searchState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : !searchState.hasSearched
                      ? const SizedBox.shrink()
                      : searchState.novels.isEmpty
                          ? Center(child: Text(l10n.searchNoResults))
                          : ListView.builder(
                              controller: _scrollController,
                              itemCount: searchState.novels.length +
                                  (searchState.isLoadingMore ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index == searchState.novels.length) {
                                  return const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                }
                                final novel = searchState.novels[index];
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
                                        borderRadius:
                                            BorderRadius.circular(12),
                                        onPressed: (context) async {
                                          await ref
                                              .read(databaseHelperProvider)
                                              .insertItem(
                                                Item(
                                                  title: novel.title,
                                                  ncode: novel.ncode,
                                                  story: novel.story,
                                                  writer: novel.writer,
                                                  biggenre: novel.biggenre,
                                                  genre: novel.genre,
                                                  keywords: novel.keywords,
                                                  novelType: novel.novelType,
                                                  length: novel.length,
                                                  time: novel.time,
                                                  globalPoint:
                                                      novel.globalPoint,
                                                  favNovelCunt:
                                                      novel.favNovelCunt,
                                                  generalFirstup: novel
                                                      .generalFirstup
                                                      .toIso8601String(),
                                                  generalLastup: novel
                                                      .generalLastup
                                                      .toIso8601String(),
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
                                          builder: (context) =>
                                              DetailPage(novel: novel),
                                        ),
                                      );
                                    },
                                  ),
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
