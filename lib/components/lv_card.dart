import 'package:flutter/material.dart';

class LVCard extends StatelessWidget {
  const LVCard(
      {super.key, this.child, this.color, this.borderRadius, this.elevation});

  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final Widget? child;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? Theme.of(context).colorScheme.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
      elevation: elevation ?? 0,
      child: child,
    );
  }
}
