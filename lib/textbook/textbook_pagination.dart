import 'package:flutter/foundation.dart';

import 'package:czydobrze/textbook/textbook.dart';

class TextbookPagination {
  final List<Textbook> textbooks;
  final int page;
  final String errorMessage;
  final bool finished;

  TextbookPagination({
    required this.textbooks,
    required this.page,
    required this.errorMessage,
    required this.finished,
  });

  TextbookPagination.initial() : textbooks = [], page = 0, errorMessage = '', finished = false;

  get refreshError => errorMessage != '' && textbooks.length < 20;

  TextbookPagination copyWith({
    List<Textbook>? textbooks,
    int? page,
    String? errorMessage,
    bool? finished,
  }) {
    return TextbookPagination(
      textbooks: textbooks ?? this.textbooks,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
      finished: finished ?? this.finished,
    );
  }

  @override
  String toString() {
    return 'TextbookPagination(textbooks: $textbooks, page: $page, errorMessage: $errorMessage, finished: $finished)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TextbookPagination &&
      listEquals(other.textbooks, textbooks) &&
      other.page == page &&
      other.errorMessage == errorMessage &&
      other.finished == finished;
  }

  @override
  int get hashCode {
    return textbooks.hashCode ^
      page.hashCode ^
      errorMessage.hashCode ^
      finished.hashCode;
  }
}
