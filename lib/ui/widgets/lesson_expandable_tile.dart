import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class LessonExpandableTile extends StatefulWidget {
  const LessonExpandableTile({
    super.key,
  });

  @override
  State<LessonExpandableTile> createState() => _LessonExpandableTileState();
}

class _LessonExpandableTileState extends State<LessonExpandableTile> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color:
                    Theme.of(context).colorScheme.onSecondary.withOpacity(.3),
              ),
            ),
          ),
          child: ListTile(
            onTap: () {
              setState(() {
                isOpen = !isOpen;
              });
            },
            title: const AutoSizeText(
              'Lesson Title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(
              !isOpen ? Icons.arrow_drop_down : Icons.arrow_drop_up,
            ),
          ),
        ),
        if (isOpen)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: List<Widget>.generate(
                5,
                (index) => Row(
                  children: [
                    const AutoSizeText(
                      'Topic Title',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    AutoSizeText(
                      'hour:minute',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(.7),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
