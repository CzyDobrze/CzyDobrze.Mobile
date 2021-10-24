class Section {
  final String id;
  final String title;
  final String description;

  Section(this.id, this.title, this.description);

  factory Section.fromJson(Map<String, dynamic> data) {
    return Section(
      data['id'],
      data['title'],
      data['description'],
    );
  }
}