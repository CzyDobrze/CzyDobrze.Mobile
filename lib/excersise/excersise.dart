class Excersise {
  final String id;
  final String title;
  final String description;

  Excersise(this.id, this.title, this.description);

  factory Excersise.fromJson(Map<String, dynamic> data) {
    return Excersise(
      data['id'],
      data['title'],
      data['description'],
    );
  }
}