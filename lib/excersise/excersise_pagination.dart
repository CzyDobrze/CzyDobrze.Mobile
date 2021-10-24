import 'package:flutter/foundation.dart';

import 'package:czydobrze/excersise/excersise.dart';

class ExcersisePagination {
  final List<Excersise> excersises;
  final int page;
  final String errorMessage;
  final bool finished;

  ExcersisePagination({
    required this.excersises,
    required this.page,
    required this.errorMessage,
    required this.finished,
  });
  
  ExcersisePagination.initial() : excersises = [], page = 0, errorMessage = '', finished = false;

  get refreshError => errorMessage != '' && excersises.length < 20;

  ExcersisePagination copyWith({
    List<Excersise>? excersises,
    int? page,
    String? errorMessage,
    bool? finished,
  }) {
    return ExcersisePagination(
      excersises: excersises ?? this.excersises,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
      finished: finished ?? this.finished,
    );
  }

  @override
  String toString() {
    return 'ExcersisePagination(excersises: $excersises, page: $page, errorMessage: $errorMessage, finished: $finished)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ExcersisePagination &&
      listEquals(other.excersises, excersises) &&
      other.page == page &&
      other.errorMessage == errorMessage &&
      other.finished == finished;
  }

  @override
  int get hashCode {
    return excersises.hashCode ^
      page.hashCode ^
      errorMessage.hashCode ^
      finished.hashCode;
  }
}
