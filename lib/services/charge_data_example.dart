import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/course.dart';
import '../models/evaluation.dart'; // Importa tu modelo Course aquí

class SampleService {
  SampleService._();

  static Future<void> createSampleData() async {
    final coursesCollection = FirebaseFirestore.instance.collection('courses');

    // Cursos de ejemplo
    List<Course> sampleCourses = [
      Course(
        id: 'flutter-101',
        title: 'Flutter para Principiantes',
        description: 'Curso básico para aprender Flutter desde cero.',
        instructorId: 'cBDU46DwPpgkIOPS9hnKIJtskXC2',
        studentsEnrolled: ['stu-1', 'stu-2'],
        contentUrls: ['https://flutter.dev'],
        imageUrl: 'https://example.com/flutter.jpg',
      ),
      Course(
        id: 'flutter-advanced',
        title: 'Flutter Avanzado',
        description: 'Profundiza en el desarrollo con Flutter.',
        instructorId: 'cBDU46DwPpgkIOPS9hnKIJtskXC2',
        studentsEnrolled: ['stu-3'],
        contentUrls: ['https://flutter.dev/advanced'],
        imageUrl: 'https://example.com/flutter-advanced.jpg',
      ),
    ];

    for (var course in sampleCourses) {
      // Subir curso a Firebase
      await coursesCollection.doc(course.id).set(course.toFirestore());

      // Evaluaciones de ejemplo para cada curso
      List<Evaluation> evaluations = [
        Evaluation(
          courseId: course.id!,
          studentId: 'stu-1',
          score: 85,
          feedback: 'Muy buen curso.',
        ),
        Evaluation(
          courseId: course.id!,
          studentId: 'stu-2',
          score: 90,
          feedback: 'Aprendí mucho sobre Flutter.',
        ),
      ];

      // Subir evaluaciones como subcolección
      for (var eval in evaluations) {
        await coursesCollection
            .doc(course.id)
            .collection('evaluations')
            .doc(eval.id)
            .set(eval.toFirestore());
      }
    }
  }
}
