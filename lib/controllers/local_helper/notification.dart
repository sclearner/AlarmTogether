import 'package:alarmtogether/controllers/firebase_helper/authentication.dart';
import 'package:alarmtogether/controllers/firebase_helper/server_data.dart';
import 'package:alarmtogether/firebase_options.dart';
import 'package:alarmtogether/models/alarm.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';
import 'package:timezone/timezone.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class LocalNotificationHelper {

  @pragma('vm:entry-point')
  static void callbackDispatcher() {
    Workmanager().executeTask((taskName, inputData) async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();

      var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
      var iOS = DarwinInitializationSettings();

      var settings = InitializationSettings(android: android, iOS: iOS);

      flip.initialize(settings);



      Map<String, Alarm> alarms = await ServerData.readAllAlarm();
      for (int i = 0; i < alarms.entries.length; i++) {
          Alarm alarm = alarms.values.elementAt(i);
          showNotification2(flip, i, alarm);
      }
      return Future.value(true);
    });
  }

  static void showNotification(
      FlutterLocalNotificationsPlugin flip, int id, Alarm alarm) async {
    if (!alarm.affectID!.contains(Authentication.user?.uid)) return;

    var android = const AndroidNotificationDetails('id', 'name',
        channelDescription: 'description',
        importance: Importance.max,
        priority: Priority.high);
    var iOS = const DarwinNotificationDetails();

    var platformChannel = NotificationDetails(android: android, iOS: iOS);

    var body = "${DateFormat.jm().format(alarm.time)} - ${alarm.message}";

    DateTime alarmTime = alarm.time;
    DateTime scheduleTime = DateTime.now()
        .copyWith(hour: alarmTime.hour, minute: alarmTime.minute, second: 0);

    List<bool> schedule = alarm.isRepeated;
    if (scheduleTime.compareTo(DateTime.now()) < 0) {
      scheduleTime.add(const Duration(days: 1));
    }
    int dayOfWeek = scheduleTime.weekday - 1;
    if (schedule.any((e) => e == true)) {
      //One time
      while (!schedule[dayOfWeek]) {
        scheduleTime.add(const Duration(days: 1));
        dayOfWeek = scheduleTime.weekday - 1;
      }
    }

    print(scheduleTime);

    await flip.zonedSchedule(
        id, alarm.title, body, scheduleTime.tz, platformChannel,
        payload: 'Default_Sound',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,);
  }

  static void showNotification2(
      FlutterLocalNotificationsPlugin flip, int id, Alarm alarm) async {
    if (!alarm.affectID!.contains(Authentication.user?.uid)) return;

    var android = const AndroidNotificationDetails('id', 'name',
        channelDescription: 'description',
        importance: Importance.max,
        priority: Priority.high);
    var iOS = const DarwinNotificationDetails();

    var platformChannel = NotificationDetails(android: android, iOS: iOS);

    var body = "${DateFormat.jm().format(alarm.time)} - ${alarm.message}";

    DateTime alarmTime = alarm.time;
    DateTime scheduleTime = DateTime.now()
        .copyWith(hour: alarmTime.hour, minute: alarmTime.minute, second: 0);

    List<bool> schedule = alarm.isRepeated;
    if (scheduleTime.compareTo(DateTime.now()) < 0) {
      scheduleTime.add(const Duration(days: 1));
    }
    int dayOfWeek = scheduleTime.weekday - 1;
    if (schedule.any((e) => e == true)) {
      //One time
      while (!schedule[dayOfWeek]) {
        scheduleTime.add(const Duration(days: 1));
        dayOfWeek = scheduleTime.weekday - 1;
      }
    }

    print(scheduleTime);

    await flip.show(
      id, alarm.title, body, platformChannel,
      payload: 'Default_Sound',);
  }
}

extension ChangeTZ on DateTime {
  TZDateTime get tz {
    return TZDateTime.local(year, month, day, hour, minute, second);
  }
}
