import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  factory Note.fromFirestore(Map<String, dynamic> data, String id) {
    DateTime date;
    if (data['createdAt'] is Timestamp) {
      date = (data['createdAt'] as Timestamp).toDate();
    } else if (data['createdAt'] is String) {
      date = DateTime.tryParse(data['createdAt']) ?? DateTime.now();
    } else {
      date = DateTime.now();
    }

    return Note(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      createdAt: date,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
