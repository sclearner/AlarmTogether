abstract class AppRoutes {
  static const String home = "/";
  static const String alarm = "/";
  static const String currentAlarm = "/alarm/:$pathCurrentAlarm";
  static const String pathCurrentAlarm = "alarmID";
  static const String settings = "/settings";
}