import 'package:flutter/foundation.dart';

import 'package:czydobrze/excersise/excersise.dart';

class ExcersisePagination {
  final List<Excersise> excersises;
  final int page;
  final String errorMessage;

  ExcersisePagination({
    required this.excersises,
    required this.page,
    required this.errorMessage,
  });
  
  ExcersisePagination.initial() : excersises = [], page = 0, errorMessage = '';

  get refreshError => errorMessage != '' && excersises.length < 20;

  ExcersisePagination copyWith({
    List<Excersise>? excersises,
    int? page,
    String? errorMessage,
  }) {
    return ExcersisePagination(
      excersises: excersises ?? this.excersises,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() => 'ExcersisePagination(excersises: $excersises, page: $page, errorMessage: $errorMessage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ExcersisePagination &&
      listEquals(other.excersises, excersises) &&
      other.page == page &&
      other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => excersises.hashCode ^ page.hashCode ^ errorMessage.hashCode;
}
