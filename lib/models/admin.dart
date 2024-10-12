import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learndid/models/user.dart';

class Admin extends User {
  Admin({
    required super.uid,
    required super.name,
    required super.email,
  }) : super(role: 'admin');

  // Convertir desde/para Firestore
  factory Admin.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Admin(
      uid: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'role': role,
    };
  }
}
