import 'package:flutter/material.dart';
import 'package:learndid/services/firebase_service.dart';
import 'package:learndid/ui/widgets/course_card.dart';

class CoursesGridView extends StatelessWidget {
  const CoursesGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return FutureBuilder(
            future: FirebaseService.getCourses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                );
              } else {
                final courses = snapshot.data;
                if (courses == null || courses.isEmpty) {
                  return const Center(
                    child: Text('No se encontraron cursos'),
                  );
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth <= 400
                        ? 1
                        : constraints.maxWidth <= 800
                            ? 2
                            : constraints.maxWidth <= 1200
                                ? 3
                                : 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: constraints.maxWidth < 280
                        ? .68
                        : (constraints.maxWidth > 280 &&
                                constraints.maxWidth < 400)
                            ? 1
                            : (constraints.maxWidth > 400 &&
                                    constraints.maxWidth < 611)
                                ? .68
                                : .9,
                  ),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    return CourseCard(
                      course: courses[index],
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
