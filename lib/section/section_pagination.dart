import 'package:flutter/foundation.dart';

import 'package:czydobrze/section/section.dart';

class SectionPagination {
  final List<Section> sections;
  final int page;
  final String errorMessage;

  SectionPagination({
    required this.sections,
    required this.page,
    required this.errorMessage,
  });
  
  SectionPagination.initial() : sections = [], page = 0, errorMessage = '';

  get refreshError => errorMessage != '' && sections.length < 20;

  SectionPagination copyWith({
    List<Section>? sections,
    int? page,
    String? errorMessage,
  }) {
    return SectionPagination(
      sections: sections ?? this.sections,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() => 'SectionPagination(sections: $sections, page: $page, errorMessage: $errorMessage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SectionPagination &&
      listEquals(other.sections, sections) &&
      other.page == page &&
      other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => sections.hashCode ^ page.hashCode ^ errorMessage.hashCode;
}
