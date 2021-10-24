import 'package:czydobrze/services/api_service.dart';
import 'package:czydobrze/excersise/excersise_pagination.dart';
import 'package:czydobrze/section/section.dart';
import 'package:riverpod/riverpod.dart';

final excersisePaginationControllerProvider = StateNotifierProvider.family<
    ExcersisePaginationController, ExcersisePagination, Section>((ref, section) {
  final apiService = ref.read(apiServiceProvider);
  return ExcersisePaginationController(apiService, section);
});

class ExcersisePaginationController extends StateNotifier<ExcersisePagination> {
  final Section section;

  ExcersisePaginationController(this._apiService, this.section,
      [ExcersisePagination? state])
      : super(state ?? ExcersisePagination.initial()) {
    getExcersises();
  }

  final ApiService _apiService;

  Future<void> getExcersises() async {
    try {
      final excersises = await _apiService.getExcersises(
        section,
        state.page,
      );
      state = state.copyWith(
          excersises: [...state.excersises, ...excersises], page: state.page + 1, finished: excersises.isEmpty);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  void handleScrollWithIndex(int index) {
    final itemPosition = index + 1;

    if (!state.finished && state.excersises.length - itemPosition < 10) {
      getExcersises();
    }
  }
}
