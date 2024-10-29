import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learndid/models/user.dart';

class Instructor extends User {
  List<String> createdCourses; // IDs de los cursos creados por el instructor

  Instructor({
    required super.uid,
    required super.name,
    required super.email,
    required this.createdCourses,
    super.role = 'instructor',
  });

  // Convertir desde/para Firestore
  factory Instructor.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Instructor(
      uid: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      createdCourses: List<String>.from(data['createdCourses'] ?? []),
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'createdCourses': createdCourses,
    };
  }

  factory Instructor.newUser({
    String? uid,
    String? name,
    required String email,
    required List<String> createdCourses,
  }) {
    return Instructor(
      uid: uid ?? '',
      name: name ?? '',
      email: email,
      createdCourses: createdCourses,
    );
  }
}
