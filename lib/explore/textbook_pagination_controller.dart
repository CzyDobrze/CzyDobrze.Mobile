import 'package:czydobrze/api/api_service.dart';
import 'package:czydobrze/explore/textbook_pagination.dart';
import 'package:riverpod/riverpod.dart';

final TextbookPaginationControllerProvider =
    StateNotifierProvider<TextbookPaginationController, TextbookPagination>((ref) {
  final apiService = ref.read(ApiServiceProvider);
  return TextbookPaginationController(apiService);
});

class TextbookPaginationController extends StateNotifier<TextbookPagination> {
  TextbookPaginationController(this._apiService, [TextbookPagination? state])
      : super(state ?? TextbookPagination.initial()) {
    getTextbooks();
  }

  final ApiService _apiService;

  Future<void> getTextbooks() async {
    try {
      final textbooks = await _apiService.getTextbooks(state.page);
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
