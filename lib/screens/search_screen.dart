import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:naroureader/database/savedList_helper.dart';
import 'package:naroureader/models/savedList_modell.dart';
import 'package:naroureader/providers/theme_provider.dart';
// import 'package:naroureader/screens/account_Page.dart';
import 'package:naroureader/screens/detailPage.dart';
import '../models/novel.dart';
import '../services/api_survice.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Novel> _novels = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  bool _hasSearched = false;
  String _currentKeyword = '';
  int _currentPage = 1;

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
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _hasMore) {
      _loadMore();
    }
  }

  Future<void> _searchNovels(String keyword) async {
    if (keyword.isEmpty) return;
    setState(() {
      _novels = [];
      _currentKeyword = keyword;
      _currentPage = 1;
      _hasMore = true;
      _hasSearched = true;
      _isLoading = true;
    });
    try {
      final results = await ApiService().fetchNovels(keyword, page: 1);
      setState(() {
        _novels = results;
        _currentPage = 2;
        _hasMore = results.length >= 20;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || !_hasMore || _currentKeyword.isEmpty) return;
    setState(() {
      _isLoadingMore = true;
    });
    try {
      final results =
          await ApiService().fetchNovels(_currentKeyword, page: _currentPage);
      setState(() {
        _novels.addAll(results);
        _currentPage++;
        _hasMore = results.length >= 20;
        _isLoadingMore = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(l10n.searchTitle),
        // leading: IconButton(
        //   icon: const Icon(Icons.account_circle),
        //   onPressed: () => Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => const AccountPage()),
        //   ),
        // ),
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
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : !_hasSearched
                      ? const SizedBox.shrink()
                      : _novels.isEmpty
                          ? Center(child: Text(l10n.searchNoResults))
                          : ListView.builder(
                              controller: _scrollController,
                              itemCount:
                                  _novels.length + (_isLoadingMore ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index == _novels.length) {
                                  return const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                }
                                final novel = _novels[index];
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
