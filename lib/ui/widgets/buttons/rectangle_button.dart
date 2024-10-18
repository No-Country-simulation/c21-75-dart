import 'package:flutter/material.dart';

class RectangleButton extends StatelessWidget {
  const RectangleButton({
    super.key,
    required this.child,
    required this.onPressed,
  });
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      child: child,
    );
  }
}
