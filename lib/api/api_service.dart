import 'package:czydobrze/explore/course.dart';
import 'package:riverpod/riverpod.dart';

final ApiServiceProvider = Provider((ref) {
  return ApiService();
});

class ApiService {
  Future<List<Course>> getCourses([int page = 0]) async {
    return List.generate(20, (index) => Course('${page*20+index}'));
  }
}