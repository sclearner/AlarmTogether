part of 'theme.dart';

extension AppTextThemeExtension on BuildContext {
  TextStyle? get headline => Theme.of(this).textTheme.headlineMedium;
  TextStyle? get alarm => Theme.of(this).textTheme.displayLarge;
  TextStyle? get body => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get label => Theme.of(this).textTheme.labelMedium;
}

class AppTextTheme extends TextTheme {
  const AppTextTheme() : super(
    headlineMedium: const TextStyle(fontSize: 16),
    titleMedium: const TextStyle(fontSize: 16),
    titleLarge: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    bodyLarge: const TextStyle(fontSize: 18),
    bodyMedium: const TextStyle(fontSize: 16),
    labelMedium: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    displayLarge: const TextStyle(fontSize: 60, fontWeight: FontWeight.w600)

  );

  static const instance = AppTextTheme();
  static get headline => instance.headlineMedium;
  static get alarm => instance.displayLarge;
  static get body => instance.bodyMedium;
  static get label => instance.labelMedium;
}