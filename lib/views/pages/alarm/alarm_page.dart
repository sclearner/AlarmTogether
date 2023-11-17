import 'package:alarmtogether/controllers/firebase_helper/server_data.dart';
import 'package:alarmtogether/models/alarm.dart';
import 'package:alarmtogether/views/pages/alarm/alarm_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlarmPage extends StatelessWidget {
  VoidCallback _newAlarm(BuildContext context) {
    Uri uri = Uri(pathSegments: ["", "alarm", "new"]);
    return () {
      context.push(uri.toString());
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ServerData.readAllAlarm(),
        builder: (context, snapshot) {
          List<Widget> sliver = [
            SliverAppBar(
              leading: IconButton(
                icon: Icon(CupertinoIcons.add), onPressed: _newAlarm(context),),
              title: Text("Alarm"),
              centerTitle: true,
              pinned: true,
            ),
          ];
          if (snapshot.hasData) {
            var alarms = snapshot.data ?? {};
            sliver.add(
                SliverList.separated(
                  itemBuilder: (context, i) =>
                      AlarmLayout(alarmID: alarms.keys.elementAt(i),
                          alarm: alarms.values.elementAt(i)),
                  itemCount: alarms.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                )
            );
          }
          else {
            sliver.add(
              const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator(),),
              )
            );
          }
          return CustomScrollView(
            slivers: sliver,
          );
        }
    );
  }
}
