import 'package:alarmtogether/models/alarm.dart';

import 'database.dart';

abstract class ServerData {
  //C
  static void createAlarm(Alarm alarm) async {
    await Database.alarmsCollection.add(alarm.toJson());
  }

  //RA
  static Future<Map<String, Alarm>> readAllAlarm() async {
    return Database.alarmsCollection.get().then((query) => {
      for (var doc in query.docs) doc.id: Alarm.fromJson(doc.data() as Map<String, dynamic>)
    });
  }

  //U
  static void updateAlarm(String id, Alarm alarm) async {
    await Database.alarmsCollection.doc(id).update(alarm.toJson());
  }

  //D
  static void deleteAlarm(String id) async {
    await Database.alarmsCollection.doc(id).delete();
  }
}
