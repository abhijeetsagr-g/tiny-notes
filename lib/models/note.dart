class Note {
  String id;
  String title;
  String userId;
  String content;
  DateTime lastUpdated;

  Note({
    required this.id,
    required this.title,
    required this.userId,
    required this.content,
    required this.lastUpdated,
  });

  // use while pushing to a database
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'userId': userId,
      'content': content,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  // use while getting it from the database
  factory Note.fromJson(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      userId: map['userId'],
      content: map['content'],
      lastUpdated: DateTime.parse(map['lastUpdated']),
    );
  }
}
