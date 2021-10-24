class Comment {
  final String content;
  final String author;

  Comment(this.content, this.author);

  factory Comment.fromJson(Map<String, dynamic> data) {
    return Comment(
      data['content'],
      data['author'],
    );
  }
}