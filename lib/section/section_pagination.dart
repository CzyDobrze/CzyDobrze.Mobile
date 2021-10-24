import 'package:flutter/foundation.dart';

import 'package:czydobrze/section/section.dart';

class SectionPagination {
  final List<Section> sections;
  final int page;
  final String errorMessage;
  final bool finished;

  SectionPagination({
    required this.sections,
    required this.page,
    required this.errorMessage,
    required this.finished,
  });
  
  SectionPagination.initial() : sections = [], page = 0, errorMessage = '', finished = false;

  get refreshError => errorMessage != '' && sections.length < 20;

  SectionPagination copyWith({
    List<Section>? sections,
    int? page,
    String? errorMessage,
    bool? finished,
  }) {
    return SectionPagination(
      sections: sections ?? this.sections,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
      finished: finished ?? this.finished,
    );
  }

  @override
  String toString() {
    return 'SectionPagination(sections: $sections, page: $page, errorMessage: $errorMessage, finished: $finished)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SectionPagination &&
      listEquals(other.sections, sections) &&
      other.page == page &&
      other.errorMessage == errorMessage &&
      other.finished == finished;
  }

  @override
  int get hashCode {
    return sections.hashCode ^
      page.hashCode ^
      errorMessage.hashCode ^
      finished.hashCode;
  }
}
