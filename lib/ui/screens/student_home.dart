import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:learndid/services/firebase_service.dart';

import '../widgets/courses_grid_view.dart';
import '../widgets/search_bar_and_categories.dart';
import 'login_screen.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: AutoSizeText(
          'Catálogo de Cursos',
          maxLines: 1,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        leading: IconButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
          onPressed: () {
            FirebaseService.signOut().then(
              (value) {
                if (context.mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                }
              },
            );
          },
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SearchBarAndCategories(),
            CoursesGridView(),
          ],
        ),
      ),
    );
  }
}
