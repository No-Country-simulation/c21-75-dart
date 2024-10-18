import 'package:cloud_firestore/cloud_firestore.dart';

class Payment {
  String id;
  String studentId;
  String courseId;
  double amount;
  DateTime paymentDate;

  Payment({
    required this.id,
    required this.studentId,
    required this.courseId,
    required this.amount,
    required this.paymentDate,
  });

  // Convertir desde/para Firestore
  factory Payment.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Payment(
      id: doc.id,
      studentId: data['studentId'] ?? '',
      courseId: data['courseId'] ?? '',
      amount: data['amount']?.toDouble() ?? 0.0,
      paymentDate: (data['paymentDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'studentId': studentId,
      'courseId': courseId,
      'amount': amount,
      'paymentDate': paymentDate,
    };
  }
}
