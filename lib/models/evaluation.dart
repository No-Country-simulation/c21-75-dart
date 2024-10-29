import 'package:cloud_firestore/cloud_firestore.dart';

class Evaluation {
  String? id;
  String courseId; // ID del curso al que pertenece
  String studentId; // ID del estudiante que hizo la evaluación
  int score; // Puntuación (0 a 100)
  String feedback; // Comentarios del estudiante

  Evaluation({
    this.id,
    required this.courseId,
    required this.studentId,
    required this.score,
    required this.feedback,
  });

  factory Evaluation.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Evaluation(
      id: doc.id,
      courseId: data['courseId'] ?? '',
      studentId: data['studentId'] ?? '',
      score: data['score'] ?? 0,
      feedback: data['feedback'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'courseId': courseId,
      'studentId': studentId,
      'score': score,
      'feedback': feedback,
    };
  }
}
