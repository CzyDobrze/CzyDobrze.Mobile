import 'package:czydobrze/api/api_service.dart';
import 'package:czydobrze/explore/course_pagination.dart';
import 'package:riverpod/riverpod.dart';

final CoursePaginationControllerProvider = StateNotifierProvider<CoursePaginationController, CoursePagination>((ref) {
  final apiService = ref.read(ApiServiceProvider);
  return CoursePaginationController(apiService);
});

class CoursePaginationController extends StateNotifier<CoursePagination> {
  CoursePaginationController(this._apiService, [CoursePagination? state]) : super(state ?? CoursePagination.initial());
  
  final ApiService _apiService;

  Future<void> getCourses() async {
    try {
        final courses = await _apiService.getCourses(state.page);
        state = state.copyWith(courses: [...state.courses, ...courses], page: state.page + 1);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}