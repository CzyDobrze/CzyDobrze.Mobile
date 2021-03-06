import 'package:czydobrze/services/api_service.dart';
import 'package:czydobrze/textbook/textbook_pagination.dart';
import 'package:riverpod/riverpod.dart';

final textbookPaginationControllerProvider =
    StateNotifierProvider.family<TextbookPaginationController, TextbookPagination, String?>(
        (ref, query) {
  final apiService = ref.read(apiServiceProvider);
  return TextbookPaginationController(apiService, query);
});

class TextbookPaginationController extends StateNotifier<TextbookPagination> {
  final String? query;

  TextbookPaginationController(this._apiService, this.query, [TextbookPagination? state])
      : super(state ?? TextbookPagination.initial()) {
    getTextbooks();
  }

  final ApiService _apiService;

  Future<void> getTextbooks() async {
    try {
      final textbooks = await _apiService.getTextbooks(
        searchTerm: query ?? '',
        page: state.page,
      );
      state = state.copyWith(
          textbooks: [...state.textbooks, ...textbooks], page: state.page + 1, finished: textbooks.isEmpty);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  void handleScrollWithIndex(int index) {
    final itemPosition = index + 1;

    if (!state.finished && state.textbooks.length - itemPosition < 10) {
      getTextbooks();
    }
  }
}
