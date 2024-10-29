import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:learndid/models/course.dart';
import 'package:learndid/ui/widgets/buttons/rectangle_button.dart';
import 'package:learndid/utils/extension/double_to_gap_extension.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../screens/course_detail_screen.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({super.key, required this.course});

  final Course course;

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CourseDetailScreen(
            course: widget.course,
          ),
        ),
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(5),
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                key: ValueKey(widget.course.id),
                widget.course.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Skeletonizer(
                    enabled: true,
                    containersColor: Colors.grey,
                    effect: const ShimmerEffect(),
                    child: child,
                  );
                },
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  'assets/images/placeholder.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AutoSizeText(
                      widget.course.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 1,
                    ),
                    5.0.toVerticalGap,
                    AutoSizeText(
                      widget.course.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    5.0.toVerticalGap,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RectangleButton(
                child: AutoSizeText(
                  'Inscribirse',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
