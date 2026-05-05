import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/novel.dart';
import '../providers/service_providers.dart';

class SearchState {
  final List<Novel> novels;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final bool hasSearched;
  final String currentKeyword;
  final int currentPage;
  final String? errorMessage;

  const SearchState({
    this.novels = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.hasSearched = false,
    this.currentKeyword = '',
    this.currentPage = 1,
    this.errorMessage,
  });

  SearchState copyWith({
    List<Novel>? novels,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    bool? hasSearched,
    String? currentKeyword,
    int? currentPage,
    String? errorMessage,
  }) {
    return SearchState(
      novels: novels ?? this.novels,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      hasSearched: hasSearched ?? this.hasSearched,
      currentKeyword: currentKeyword ?? this.currentKeyword,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage,
    );
  }
}

class SearchViewModel extends StateNotifier<SearchState> {
  final Ref _ref;

  SearchViewModel(this._ref) : super(const SearchState());

  Future<void> search(String keyword) async {
    if (keyword.isEmpty) return;
    state = SearchState(
      currentKeyword: keyword,
      hasSearched: true,
      isLoading: true,
    );
    try {
      final results =
          await _ref.read(apiServiceProvider).fetchNovels(keyword, page: 1);
      state = state.copyWith(
        novels: results,
        currentPage: 2,
        hasMore: results.length >= 20,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.currentKeyword.isEmpty) {
      return;
    }
    state = state.copyWith(isLoadingMore: true);
    try {
      final results = await _ref.read(apiServiceProvider).fetchNovels(
            state.currentKeyword,
            page: state.currentPage,
          );
      state = state.copyWith(
        novels: [...state.novels, ...results],
        currentPage: state.currentPage + 1,
        hasMore: results.length >= 20,
        isLoadingMore: false,
      );
    } catch (_) {
      state = state.copyWith(isLoadingMore: false);
    }
  }
}

final searchViewModelProvider =
    StateNotifierProvider.autoDispose<SearchViewModel, SearchState>(
  (ref) => SearchViewModel(ref),
);
