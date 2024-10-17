import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learndid/ui/screens/student_home.dart';
import 'package:learndid/ui/style/app_theme.dart';

import 'keys/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Learndid());
}

class Learndid extends StatelessWidget {
  const Learndid({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learndid',
      theme: AppTheme.lightTheme(),
      home: const StudentHome(),
    );
  }
}
