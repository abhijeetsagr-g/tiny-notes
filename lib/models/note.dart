import 'package:flutter/material.dart';

class Note {
  String id;
  String title;
  String userId;
  String content;
  DateTime lastUpdated;
  Color bgColor;

  Note({
    required this.id,
    required this.title,
    required this.userId,
    required this.content,
    required this.lastUpdated,
    this.bgColor = Colors.grey,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'userId': userId,
      'content': content,
      'lastUpdated': lastUpdated.toIso8601String(),
      'bgColor': bgColor.toARGB32(),
    };
  }

  factory Note.fromJson(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      userId: map['userId'],
      content: map['content'],
      lastUpdated: DateTime.parse(map['lastUpdated']),
      bgColor: Color(map['bgColor']),
    );
  }
}
