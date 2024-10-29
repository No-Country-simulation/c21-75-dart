import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learndid/models/course.dart';
import 'package:learndid/utils/enum/role_enum.dart';

import '../models/evaluation.dart';
import '../models/instructor.dart';
import '../models/lection.dart';
import '../models/student.dart';

class FirebaseService {
  FirebaseService._();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> registerNewUser({
    required String email,
    required String password,
    required UserRole role,
  }) async {
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credentials.user != null) {
        if (role == UserRole.student) {
          Student student = Student.newUser(
            uid: credentials.user!.uid,
            email: email,
            enrolledCourses: [],
          );
          await _firestore
              .collection('users')
              .doc(credentials.user!.uid)
              .set(student.toFirestore());
        } else {
          Instructor instructor = Instructor.newUser(
            uid: credentials.user!.uid,
            email: email,
            createdCourses: [],
          );
          await _firestore
              .collection('users')
              .doc(credentials.user!.uid)
              .set(instructor.toFirestore());
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Future<List<Course>> getCourses() async {
    final snapshot = await _firestore.collection('courses').get();
    List<Course> courses =
        snapshot.docs.map((doc) => Course.fromFirestore(doc)).toList();
    for (Course course in courses) {
      final evaluations = await getEvaluations(courseId: course.id!);
      course.evaluations = evaluations;
      final lections = await getLections(courseId: course.id!);
      course.lections = lections;
    }
    return courses;
  }

  static Future<void> enrollCourse({
    required String courseId,
    required String studentId,
  }) async {
    final courseRef = _firestore.collection('courses').doc(courseId);

    final courseDoc = await courseRef.get();

    if (courseDoc.exists) {
      final courseData = courseDoc.data() as Map;

      final List<String> studentsEnrolled =
          List<String>.from(courseData['studentsEnrolled'] ?? []);
      studentsEnrolled.add(studentId);

      await courseRef.update({'studentsEnrolled': studentsEnrolled});
    }
  }

  static Future<void> addEvaluation({
    required String courseId,
    required String studentId,
    required int score,
    required String feedback,
  }) async {
    final evaluationRef = _firestore
        .collection('courses')
        .doc(courseId)
        .collection('evaluations')
        .doc();

    final evaluation = Evaluation(
      courseId: courseId,
      studentId: studentId,
      score: score,
      feedback: feedback,
    );

    await evaluationRef.set(evaluation.toFirestore());
  }

  static Future<void> createCourse({
    required String title,
    required String description,
    required String instructorId,
    required List<String> contentUrls,
    required String imageUrl,
  }) async {
    final courseRef = _firestore.collection('courses').doc();

    final course = Course(
      id: courseRef.id,
      title: title,
      description: description,
      instructorId: instructorId,
      studentsEnrolled: [],
      contentUrls: contentUrls,
      imageUrl: imageUrl,
    );

    await courseRef.set(course.toFirestore());
  }

  static Future<void> createLection({
    required String courseId,
    required String title,
    required List<Map<String, dynamic>> topics,
  }) async {
    final lectionRef = _firestore
        .collection('courses')
        .doc(courseId)
        .collection('lections')
        .doc();

    final lection = Lection(
      title: title,
      topics: topics
          .map((t) => LectionTopic(
                title: t['title'],
                duration: t['duration'],
              ))
          .toList(),
    );

    await lectionRef.set(lection.toFirestore());
  }

  static Future<void> createInstructor({
    required String name,
    required String email,
    required String imageUrl,
  }) async {
    final instructorRef = _firestore.collection('users').doc();

    final instructor = Instructor(
      uid: instructorRef.id,
      name: name,
      email: email,
      createdCourses: [],
    );

    await instructorRef.set(instructor.toFirestore());
  }

  static Future<void> createStudent({
    required String name,
    required String email,
  }) async {
    final studentRef = _firestore.collection('users').doc();

    final student = Student(
      uid: studentRef.id,
      name: name,
      email: email,
      enrolledCourses: [],
    );

    await studentRef.set(student.toFirestore());
  }

  static Future<List<Course>> getInstructorCourses(
      {required String instructorId}) async {
    final snapshot = await _firestore
        .collection('courses')
        .where('instructorId', isEqualTo: instructorId)
        .get();
    return snapshot.docs.map((doc) => Course.fromFirestore(doc)).toList();
  }

  static Future<List<Course>> getStudentCourses(
      {required String studentId}) async {
    final snapshot = await _firestore
        .collection('courses')
        .where(
          'studentsEnrolled',
          arrayContains: studentId,
        )
        .get();
    return snapshot.docs.map((doc) => Course.fromFirestore(doc)).toList();
  }

  static Future<List<Student>> getStudents() async {
    final snapshot = await _firestore.collection('users').get();
    return snapshot.docs.map((doc) => Student.fromFirestore(doc)).toList();
  }

  static Future<List<Instructor>> getInstructors() async {
    final snapshot = await _firestore.collection('users').get();
    return snapshot.docs.map((doc) => Instructor.fromFirestore(doc)).toList();
  }

  static Future<List<Evaluation>> getEvaluations({
    required String courseId,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('courses')
          .doc(courseId)
          .collection('evaluations')
          .get();
      return snapshot.docs.map((doc) => Evaluation.fromFirestore(doc)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<List<Lection>> getLections({required String courseId}) async {
    try {
      final snapshot = await _firestore
          .collection('courses')
          .doc(courseId)
          .collection('lections')
          .get();
      return snapshot.docs.map((doc) => Lection.fromFirestore(doc)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> updateCourse({
    required String courseId,
    required String title,
    required String description,
    required String imageUrl,
  }) async {
    final courseRef = _firestore.collection('courses').doc(courseId);

    await courseRef.update({
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    });
  }

  static Future<void> updateLection({
    required String courseId,
    required String lectionId,
    required String title,
    required List<Map<String, dynamic>> topics,
  }) async {
    final lectionRef = _firestore
        .collection('courses')
        .doc(courseId)
        .collection('lections')
        .doc(lectionId);

    final lection = Lection(
      title: title,
      topics: topics
          .map((t) => LectionTopic(
                title: t['title'],
                duration: t['duration'],
              ))
          .toList(),
    );

    await lectionRef.update(lection.toFirestore());
  }

  static Future<void> deleteCourse({required String courseId}) async {
    final courseRef = _firestore.collection('courses').doc(courseId);

    await courseRef.delete();
  }

  static Future<void> deleteLection({
    required String courseId,
    required String lectionId,
  }) async {
    final lectionRef = _firestore
        .collection('courses')
        .doc(courseId)
        .collection('lections')
        .doc(lectionId);

    await lectionRef.delete();
  }

  static Future<Instructor> getIntructorOfCourse({
    required String instructorId,
  }) async {
    final instructorDoc =
        await _firestore.collection('users').doc(instructorId).get();
    return Instructor.fromFirestore(instructorDoc);
  }

  static Future<Student> getStudentOfEvaluation(
      {required String studentId}) async {
    final studentDoc =
        await _firestore.collection('users').doc(studentId).get();
    return Student.fromFirestore(studentDoc);
  }

  static get currentUser => _auth.currentUser;
}
