import 'package:alarmtogether/models/alarm.dart';

import 'database.dart';

abstract class ServerData {
  //C
  static void createAlarm(Alarm alarm) async {
    Database.alarmsCollection.add(alarm.toJson());
  }

  //RA
  static Future<List<Alarm>> readAllAlarm() async {
    return Database.alarmsCollection.get().then((query) => [
          for (var doc in query.docs)
            Alarm.fromJson(doc.data() as Map<String, dynamic>)
        ]);
  }

  //U
  static void updateAlarm(String id, Alarm alarm) async {
    Database.alarmsCollection.doc(id).set(alarm);
  }

  //D
  static void deleteAlarm(String id) async {
    Database.alarmsCollection.doc(id).delete();
  }
}
