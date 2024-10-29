import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../models/lection.dart';

class LessonExpandableTile extends StatefulWidget {
  const LessonExpandableTile({super.key, required this.lection});

  final Lection lection;

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
            title: AutoSizeText(
              widget.lection.title,
              style: const TextStyle(
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
                widget.lection.topics.length,
                (index) => Row(
                  children: [
                    AutoSizeText(
                      widget.lection.topics[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    AutoSizeText(
                      widget.lection.topics[index].duration,
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
