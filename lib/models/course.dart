import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learndid/models/evaluation.dart';

import 'lection.dart';

class Course {
  String? id;
  String title;
  String description;
  String instructorId; // ID del instructor que creó el curso
  List<String> studentsEnrolled; // IDs de los estudiantes inscritos
  List<String> contentUrls; // URLs de los videos y materiales
  String imageUrl; // URL de la imagen del curso
  List<Evaluation>? evaluations; // Evaluaciones del curso
  List<Lection>? lections; // Lecciones del curso

  Course({
    this.id,
    required this.title,
    required this.description,
    required this.instructorId,
    required this.studentsEnrolled,
    required this.contentUrls,
    required this.imageUrl,
    this.evaluations,
    this.lections,
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
      imageUrl: data['imageUrl'] ?? '',
      evaluations: List<Evaluation>.from(
        data['evaluations']?.map((e) => Evaluation.fromFirestore(e)) ?? [],
      ),
      lections: List<Lection>.from(
        data['lections']?.map((l) => Lection.fromFirestore(l)) ?? [],
      ),
    );
  }

  factory Course.test() {
    return Course(
      id: '1',
      title: 'Curso de Flutter',
      description: 'Aprende a programar aplicaciones móviles con Flutter',
      instructorId: '1',
      studentsEnrolled: [],
      contentUrls: [],
      imageUrl: 'https://rickandmortyapi.com/api/character/avatar/464.jpeg',
      lections: [
        Lection(
          title: 'Introducción a Flutter',
          topics: [
            LectionTopic(
              title: 'Instalación de Flutter',
              duration: '10:00',
            ),
            LectionTopic(
              title: 'Creación de un proyecto',
              duration: '15:00',
            ),
          ],
        ),
        Lection(
          title: 'Widgets y layouts',
          topics: [
            LectionTopic(
              title: 'Widgets básicos',
              duration: '20:00',
            ),
            LectionTopic(
              title: 'Layouts',
              duration: '25:00',
            ),
          ],
        ),
      ],
      evaluations: [
        Evaluation(
          courseId: '1',
          studentId: 'cBDU46DwPpgkIOPS9hnKIJtskXC2',
          score: 90,
          feedback: 'Muy buen curso',
        ),
        Evaluation(
          courseId: '1',
          studentId: 'cBDU46DwPpgkIOPS9hnKIJtskXC2',
          score: 80,
          feedback: 'Excelente curso',
        ),
      ],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'instructorId': instructorId,
      'studentsEnrolled': studentsEnrolled,
      'contentUrls': contentUrls,
      'imageUrl': imageUrl,
    };
  }
}
