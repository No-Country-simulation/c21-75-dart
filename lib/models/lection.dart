import 'package:cloud_firestore/cloud_firestore.dart';

class Lection {
  final String title;
  final List<LectionTopic> topics;

  Lection({
    required this.title,
    required this.topics,
  });

  factory Lection.fromFirestore(DocumentSnapshot data) {
    return Lection(
      title: data['title'] ?? '',
      topics: List<LectionTopic>.from(
        data['topics']?.map((t) => LectionTopic.fromFirestore(t)) ?? [],
      ),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'topics': topics,
    };
  }
}

class LectionTopic {
  final String title;
  final String duration;

  LectionTopic({
    required this.title,
    required this.duration,
  });

  factory LectionTopic.fromFirestore(Map<String, dynamic> data) {
    return LectionTopic(
      title: data['title'] ?? '',
      duration: data['duration'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'duration': duration,
    };
  }
}
