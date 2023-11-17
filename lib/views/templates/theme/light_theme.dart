part of 'theme.dart';

abstract class _LightTheme {
  static const ColorScheme _lightColorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.rose,
      onPrimary: AppColors.white,
      secondary: AppColors.pink,
      onSecondary: AppColors.white,
      error: AppColors.red,
      onError: AppColors.blur,
      background: AppColors.white,
      onBackground: AppColors.black,
      surface: AppColors.lightYellow,
      onSurface: AppColors.darkenGray);

  static ThemeData themeData = ThemeData(
    useMaterial3: false,
    ///Main color scheme
      colorScheme: _lightColorScheme,
    ///Specific items
    textTheme: const AppTextTheme(),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: AppTextTheme.body
    )
  );
}