import 'package:alarmtogether/models/alarm.dart';
import 'package:alarmtogether/views/pages/alarm/alarm_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlarmPage extends StatelessWidget {
  final alarms = [
    for (int i = 0; i < 100; i++)
      Alarm(
          authorID: '',
          affectID: [],
          time: DateTime(1,1,1,6,50,0),
          isRepeated: [for (int j = 0; j < 7; j++) true]),
  ];

  VoidCallback _newAlarm(BuildContext context) {
    Uri uri = Uri(pathSegments: ["", "alarm", "new"]);
    return () {
      context.push(uri.toString());
    };
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: IconButton(icon: Icon(CupertinoIcons.add), onPressed: _newAlarm(context), ),
          title: Text("Alarm"),
          centerTitle: true,
          pinned: true,
        ),
        SliverList.separated(
          itemBuilder: (context, i) => AlarmLayout(alarmID: i.toString(), alarm: alarms[i]),
          itemCount: alarms.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        )
      ],
    );
  }
}
