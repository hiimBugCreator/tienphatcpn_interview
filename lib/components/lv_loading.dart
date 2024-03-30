import 'package:flutter/material.dart';

class LVLoading extends StatelessWidget {
  const LVLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget loadingWidget = const Center(
      child: CircularProgressIndicator(),
    );
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.2),
      child: loadingWidget,
    );
  }
}
