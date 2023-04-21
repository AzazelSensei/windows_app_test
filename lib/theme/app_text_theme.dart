import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  AppTextTheme(this.context);

  final BuildContext context;

  TextStyle get _textStyle =>
      GoogleFonts.inter(textStyle: Theme.of(context).textTheme.titleLarge);

  TextStyle get large => _textStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      );
  TextStyle get medium => _textStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );
  TextStyle get small => _textStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );
}

extension AppTextThemeEx on BuildContext {
  AppTextTheme get textTheme => AppTextTheme(this);
}
