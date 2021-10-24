import 'package:czydobrze/services/api_service.dart';
import 'package:czydobrze/section/section_pagination.dart';
import 'package:czydobrze/textbook/textbook.dart';
import 'package:riverpod/riverpod.dart';

final sectionPaginationControllerProvider = StateNotifierProvider.family<
    SectionPaginationController, SectionPagination, Textbook>((ref, textbook) {
  final apiService = ref.read(apiServiceProvider);
  return SectionPaginationController(apiService, textbook);
});

class SectionPaginationController extends StateNotifier<SectionPagination> {
  final Textbook textbook;

  SectionPaginationController(this._apiService, this.textbook,
      [SectionPagination? state])
      : super(state ?? SectionPagination.initial()) {
    getSections();
  }

  final ApiService _apiService;

  Future<void> getSections() async {
    try {
      final sections = await _apiService.getSections(
        textbook,
        state.page,
      );
      state = state.copyWith(
          sections: [...state.sections, ...sections], page: state.page + 1, finished: sections.isEmpty);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  void handleScrollWithIndex(int index) {
    final itemPosition = index + 1;

    if (!state.finished && state.sections.length - itemPosition < 10) {
      getSections();
    }
  }
}
