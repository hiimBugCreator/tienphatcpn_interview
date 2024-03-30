import 'package:flutter/cupertino.dart';

extension IntExtensions on int {
  SizedBox get vertical => SizedBox(height: toDouble());
  SizedBox get horizontal => SizedBox(width: toDouble());
}