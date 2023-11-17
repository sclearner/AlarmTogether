import 'package:alarmtogether/views/templates/color/colors.dart';
import 'package:flutter/material.dart';

part 'dark_theme.dart';
part 'light_theme.dart';
part 'text_theme.dart';

abstract class AppTheme {
  static final light = _LightTheme.themeData;
  static final dark = _DarkTheme.themeData;
}