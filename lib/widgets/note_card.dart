import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tiny_notes/models/note.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note});
  final Note note;

  String formatTime(DateTime dateTime) {
    // Example: system locale → en_US, fr_FR, hi_IN, etc.
    final locale = Intl.getCurrentLocale();

    // Use the locale when formatting
    return DateFormat.yMMMd(locale).add_jm().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                note.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(note.content),
              SizedBox(height: 10),
              Text(formatTime(note.lastUpdated)),
            ],
          ),
        ),
      ),
    );
  }
}
