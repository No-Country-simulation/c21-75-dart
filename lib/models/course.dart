import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  String id;
  String title;
  String description;
  String instructorId; // ID del instructor que creó el curso
  List<String> studentsEnrolled; // IDs de los estudiantes inscritos
  List<String> contentUrls; // URLs de los videos y materiales

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructorId,
    required this.studentsEnrolled,
    required this.contentUrls,
  });

  // Convertir desde/para Firestore
  factory Course.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Course(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      instructorId: data['instructorId'] ?? '',
      studentsEnrolled: List<String>.from(data['studentsEnrolled'] ?? []),
      contentUrls: List<String>.from(data['contentUrls'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'instructorId': instructorId,
      'studentsEnrolled': studentsEnrolled,
      'contentUrls': contentUrls,
    };
  }
}
