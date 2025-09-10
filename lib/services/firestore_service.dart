import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny_notes/models/note.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveNotes(Note note) async {}
}
