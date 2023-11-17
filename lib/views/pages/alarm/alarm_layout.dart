import 'package:alarmtogether/models/alarm.dart';
import 'package:alarmtogether/views/templates/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AlarmLayout extends StatelessWidget {
  final String alarmID;
  final Alarm alarm;

  const AlarmLayout({super.key, required this.alarm, required this.alarmID});

  Widget get _time {
    DateFormat format = DateFormat.jm();
    return Text(format.format(alarm.time), style: AppTextTheme.alarm);
  }

  Widget get _repeat {
    final days = DateFormat.EEEE().dateSymbols.STANDALONESHORTWEEKDAYS;
    List<String> alarmDays = [];
    for (int i = 0; i < days.length; i++) {
      if (alarm.isRepeated[i]) alarmDays.add(days[i]);
    }
    if (alarmDays.isEmpty) {
      return Text("One time");
    }
    if (alarmDays.length == days.length) return Text("Everyday");
    return Text(alarmDays.join(", "));
  }

  void Function() _onTap(BuildContext context) {
    Uri uri = Uri(pathSegments: ["", "alarm", alarmID]);
    return () {
      context.push(uri.toString(), extra: alarm);
    };
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(alarm.title ?? "New Alarm", style: AppTextTheme.label,),
                    _time,
                    _repeat
                  ],
                ),
                Switch(value: true, onChanged: (bool) {})
              ],
        ),
      ),
    );
  }
}