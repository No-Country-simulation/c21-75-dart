import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learndid/models/user.dart';

class Student extends User {
  List<String> enrolledCourses; // IDs de los cursos a los que está inscrito

  Student({
    required super.uid,
    required super.name,
    required super.email,
    required this.enrolledCourses,
  }) : super(role: 'student');

  // Convertir desde/para Firestore
  factory Student.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Student(
      uid: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      enrolledCourses: List<String>.from(data['enrolledCourses'] ?? []),
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'enrolledCourses': enrolledCourses,
    };
  }
}
