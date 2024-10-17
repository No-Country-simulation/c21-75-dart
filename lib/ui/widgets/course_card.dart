import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          builder: (context) => const CourseDetailScreen(),
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
              child: SvgPicture.network(
                key: ValueKey(widget.course.id),
                widget.course.iconUrl,
                fit: BoxFit.fitHeight,
                placeholderBuilder: (context) => Skeletonizer(
                  child: Container(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
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
                      widget.course.summary,
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
