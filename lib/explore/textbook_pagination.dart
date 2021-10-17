import 'package:flutter/foundation.dart';

import 'package:czydobrze/textbook/textbook.dart';

class TextbookPagination {
  final List<Textbook> textbooks;
  final int page;
  final String errorMessage;
  final String? searchTerm;
  TextbookPagination({
    required this.textbooks,
    required this.page,
    required this.errorMessage,
    this.searchTerm,
  });

  TextbookPagination.initial() : textbooks = [], page = 0, errorMessage = '', searchTerm = null;

  get refreshError => errorMessage != '' && textbooks.length < 20;

  TextbookPagination copyWith({
    List<Textbook>? textbooks,
    int? page,
    String? errorMessage,
    String? searchTerm,
  }) {
    return TextbookPagination(
      textbooks: textbooks ?? this.textbooks,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  @override
  String toString() {
    return 'TextbookPagination(textbooks: $textbooks, page: $page, errorMessage: $errorMessage, searchTerm: $searchTerm)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TextbookPagination &&
      listEquals(other.textbooks, textbooks) &&
      other.page == page &&
      other.errorMessage == errorMessage &&
      other.searchTerm == searchTerm;
  }

  @override
  int get hashCode {
    return textbooks.hashCode ^
      page.hashCode ^
      errorMessage.hashCode ^
      searchTerm.hashCode;
  }
}
