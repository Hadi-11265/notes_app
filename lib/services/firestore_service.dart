import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note_model.dart';

class FirestoreService {
  CollectionReference get _notesCollection =>
      FirebaseFirestore.instance.collection('notes');

  
  Future<void> addNote(String title, String description) async {
    try {
      await _notesCollection.add({
        'title': title,
        'description': description,
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Failed to add note.: $e');
    }
  }

 
  Stream<List<Note>> getNotes() {
    return _notesCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Note.fromFirestore(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    });
  }

  
  Future<void> updateNote(String id, String title, String description) async {
    try {
      await _notesCollection.doc(id).update({
        'title': title,
        'description': description,
      });
    } catch (e) {
      throw Exception('Update Failed: $e');
    }
  }

 
  Future<void> deleteNote(String id) async {
    try {
      await _notesCollection.doc(id).delete();
    } catch (e) {
      throw Exception('Failed Delete: $e');
    }
  }
}
