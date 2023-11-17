part of 'theme.dart';

abstract class _DarkTheme {
  static const ColorScheme _darkColorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.amber,
      onPrimary: AppColors.black,
      secondary: AppColors.lava,
      onSecondary: AppColors.white,
      error: AppColors.lightRed,
      onError: AppColors.yellow,
      background: AppColors.darkLord,
      onBackground: AppColors.amber,
      surface: AppColors.lord,
      onSurface: AppColors.amber);

  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    ///Main color scheme
      colorScheme: _darkColorScheme,
    ///Specific items
      textTheme: const AppTextTheme(),
  );
}