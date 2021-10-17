import 'package:czydobrze/api/api_service.dart';
import 'package:czydobrze/explore/textbook_pagination.dart';
import 'package:riverpod/riverpod.dart';

final TextbookPaginationControllerProvider =
    StateNotifierProvider.family<TextbookPaginationController, TextbookPagination, String?>(
        (ref, query) {
  final apiService = ref.read(ApiServiceProvider);
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
          textbooks: [...state.textbooks, ...textbooks], page: state.page + 1);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  void handleScrollWithIndex(int index) {
    final itemPosition = index + 1;
    final requestMoreData = itemPosition % 20 == 0 && itemPosition != 0;
    final pageToRequest = itemPosition ~/ 20;

    if (requestMoreData && pageToRequest + 1 >= state.page) {
      getTextbooks();
    }
  }
}
