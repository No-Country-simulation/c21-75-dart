import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:learndid/models/course.dart';
import 'package:learndid/models/instructor.dart';
import 'package:learndid/services/firebase_service.dart';
import 'package:learndid/ui/screens/video_and_comments.dart';
import 'package:learndid/ui/widgets/buttons/rectangle_button.dart';
import 'package:learndid/utils/extension/double_to_gap_extension.dart';

import '../widgets/lesson_expandable_tile.dart';

class CourseDetailScreen extends StatelessWidget {
  const CourseDetailScreen({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    debugPrint('CourseDetailScreen: ${course.lections}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              course.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            20.0.toVerticalGap,
            AutoSizeText(
              course.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            20.0.toVerticalGap,
            FutureBuilder(
                future: FirebaseService.getIntructorOfCourse(
                  instructorId: course.instructorId,
                ),
                builder: (context, snapshot) {
                  Instructor? instructor;
                  if (snapshot.connectionState != ConnectionState.waiting &&
                      snapshot.data != null) {
                    instructor = snapshot.data!;
                  }
                  return AutoSizeText.rich(
                    TextSpan(
                      text: 'Instructor: ',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      children: [
                        TextSpan(
                          text: instructor != null
                              ? ' ${instructor.name}'
                              : 'Instructor Name',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  );
                }),
            20.0.toVerticalGap,
            RectangleButton(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: AutoSizeText(
                  'Incribirse al curso',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => VideoAndComments(
                      course: course,
                    ),
                  ),
                );
              },
            ),
            20.0.toVerticalGap,
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .onSecondary
                        .withOpacity(.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AutoSizeText(
                      'Course Content',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: course.lections?.length,
                        itemBuilder: (context, index) => LessonExpandableTile(
                          lection: course.lections![index],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
