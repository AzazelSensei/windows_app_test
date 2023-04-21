import 'package:flutter/material.dart';

extension BorderRadiusExtension on num {
  BorderRadius get radius => BorderRadius.circular(toDouble());
  EdgeInsets get padding => EdgeInsets.all(toDouble());
}
