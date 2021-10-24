class Textbook {
  final String id;
  final String title;
  final String subject;
  final String publisher;
  String classYear = '';

  Textbook(this.id, this.title, this.subject, this.publisher, int _classYear) {
    classYear = '${_classYear<9?_classYear:_classYear-8} ${_classYear>8?"liceum":"szkoły podstawowej"}';
  }

  factory Textbook.fromJson(Map<String, dynamic> data) {
    return Textbook(
      data['id'],
      data['title'],
      data['subject'],
      data['publisher'],
      data['classYear'],
    );
  }

  String get searchTerm {
    return '$title Class $classYear'.toLowerCase();
  }
}