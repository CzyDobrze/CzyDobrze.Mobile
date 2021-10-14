import 'package:flutter/foundation.dart';

import 'package:czydobrze/explore/course.dart';

class CoursePagination {
  final List<Course> courses;
  final int page;
  final String errorMessage;
  CoursePagination({
    required this.courses,
    required this.page,
    required this.errorMessage,
  });

  CoursePagination.initial() : courses = [], page = 0, errorMessage = '';

  get refreshError => errorMessage != '' && courses.length < 20;

  CoursePagination copyWith({
    List<Course>? courses,
    int? page,
    String? errorMessage,
  }) {
    return CoursePagination(
      courses: courses ?? this.courses,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() => 'CoursePagination(courses: $courses, page: $page, errorMessage: $errorMessage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CoursePagination &&
      listEquals(other.courses, courses) &&
      other.page == page &&
      other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => courses.hashCode ^ page.hashCode ^ errorMessage.hashCode;
}
