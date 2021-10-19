import 'package:flutter/foundation.dart';

import 'package:czydobrze/textbook/textbook.dart';

class TextbookPagination {
  final List<Textbook> textbooks;
  final int page;
  final String errorMessage;

  TextbookPagination({
    required this.textbooks,
    required this.page,
    required this.errorMessage,
  });

  TextbookPagination.initial() : textbooks = [], page = 0, errorMessage = '';

  get refreshError => errorMessage != '' && textbooks.length < 20;

  TextbookPagination copyWith({
    List<Textbook>? textbooks,
    int? page,
    String? errorMessage,
  }) {
    return TextbookPagination(
      textbooks: textbooks ?? this.textbooks,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() => 'TextbookPagination(textbooks: $textbooks, page: $page, errorMessage: $errorMessage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TextbookPagination &&
      listEquals(other.textbooks, textbooks) &&
      other.page == page &&
      other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => textbooks.hashCode ^ page.hashCode ^ errorMessage.hashCode;
}
