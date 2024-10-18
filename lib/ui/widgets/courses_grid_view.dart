import 'package:flutter/material.dart';
import 'package:learndid/ui/widgets/course_card.dart';

import '../../models/course.dart';

class CoursesGridView extends StatelessWidget {
  const CoursesGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
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
                  : (constraints.maxWidth > 280 && constraints.maxWidth < 400)
                      ? 1
                      : (constraints.maxWidth > 400 &&
                              constraints.maxWidth < 611)
                          ? .68
                          : .9,
            ),
            itemBuilder: (context, index) {
              return CourseCard(
                course: Course.test(),
              );
            },
          );
        },
      ),
    );
  }
}
