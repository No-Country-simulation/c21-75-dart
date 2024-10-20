import 'package:flutter/widgets.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.smallLayout,
    required this.mediumLayout,
    required this.largeLayout,
  });

  static const double _smallWidth = 600;
  static const double _mediumWidth = 1200;

  final Widget smallLayout;
  final Widget mediumLayout;
  final Widget largeLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < _smallWidth) {
          return smallLayout;
        } else if (constraints.maxWidth < _mediumWidth) {
          return mediumLayout;
        } else {
          return largeLayout;
        }
      },
    );
  }
}
