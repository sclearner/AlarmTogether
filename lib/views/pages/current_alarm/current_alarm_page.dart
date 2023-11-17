import 'package:alarmtogether/controllers/bloc/alarm_bloc.dart';
import 'package:alarmtogether/controllers/firebase_helper/server_data.dart';
import 'package:alarmtogether/models/alarm.dart';
import 'package:alarmtogether/views/pages/current_alarm/repeat_selector.dart';
import 'package:alarmtogether/views/pages/current_alarm/ringtone_selector.dart';
import 'package:alarmtogether/views/templates/color/colors.dart';
import 'package:alarmtogether/views/templates/theme/theme.dart';
import 'package:alarmtogether/controllers/formatters/time_input_formatter.dart';
import 'package:alarmtogether/views/widgets/time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CurrentAlarmPage extends StatelessWidget {
  const CurrentAlarmPage({super.key, required this.alarmId, this.alarm});

  final String alarmId;
  final Alarm? alarm;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (_) => AlarmBloc(alarm),
      child: CurrentAlarmBody(
        alarmId: alarmId,
        alarm: alarm,
      ),
    );
  }
}

class CurrentAlarmBody extends StatefulWidget {
  final String alarmId;
  final Alarm? alarm;

  const CurrentAlarmBody({super.key, required this.alarmId, this.alarm});

  @override
  State<CurrentAlarmBody> createState() => _CurrentAlarmPageState();
}

class _CurrentAlarmPageState extends State<CurrentAlarmBody> {
  late final TextEditingController titleController;
  late final TextEditingController timeController;
  late final TextEditingController messageController;
  late final FocusNode titleNode, timeNode, messageNode;

  final GlobalKey<TimePickerState> _timeKey = GlobalKey();

  late DateTime _currentTime;

  get _isNew => widget.alarmId == "new";

  get lastRepeater =>
      List<bool>.from(context.read<AlarmBloc>().state['isRepeated']);

  get lastRingtone => context.read<AlarmBloc>().state['ringTone'];

  Alarm get _alarmRes => context.read<AlarmBloc>().alarm;

  VoidCallback _save(BuildContext context) {
    return () async {
      if (_isNew) {
        ServerData.createAlarm(_alarmRes);
      } else {
        ServerData.updateAlarm(widget.alarmId, _alarmRes);
      }
      context.pop();
    };
  }

  void _showRepeatSelectionDialog() async {
    final List<bool>? results = await showDialog(
        context: context,
        builder: (context) => RepeatSelector(lastRepeater: lastRepeater));

    if (results != null && context.mounted) {
      setState(() {
        context.read<AlarmBloc>().changeField('isRepeated', results);
      });
    }
  }

  void _showRingtoneSelectionDialog() async {
    final String? result = await showDialog(
        context: context,
        builder: (context) => RingtoneSelector(
              lastRingtone: lastRingtone,
            ));
    if (result != null && context.mounted) {
      setState(() {
        context.read<AlarmBloc>().changeField('ringTone', result);
      });
    }
  }

  bool get isEditingTime => timeNode.hasPrimaryFocus;

  Widget _repeat(Map<String, dynamic> json) {
    final days = DateFormat.EEEE().dateSymbols.STANDALONESHORTWEEKDAYS;
    List<String> alarmDays = [];
    for (int i = 0; i < days.length; i++) {
      if (json['isRepeated'][i]) alarmDays.add(days[i]);
    }
    if (alarmDays.isEmpty) {
      return const Text(
        "One time",
        textAlign: TextAlign.right,
      );
    }
    if (alarmDays.length == days.length) {
      return const Text(
        "Everyday",
        textAlign: TextAlign.right,
      );
    }
    return Text(
      alarmDays.join(", "),
      textAlign: TextAlign.right,
    );
  }

  DateTime timeParse(state) {
    if (state['time'] != null) {
      return DateTime.parse(state['time']);
    } else {
      return _currentTime;
    }
  }

  @override
  void initState() {
    super.initState();
    _currentTime = widget.alarm?.time ?? DateTime.now();
    titleNode = FocusNode();
    titleController =
        TextEditingController(text: context.read<AlarmBloc>().state['title']);
    timeNode = FocusNode();
    timeController = TextEditingController();
    messageController =
        TextEditingController(text: context.read<AlarmBloc>().state['message']);
    messageNode = FocusNode();
    timeController.text = DateFormat().add_Hm().format(_currentTime);
  }

  @override
  void dispose() {
    timeController.dispose();
    timeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: TextField(
            controller: titleController,
            focusNode: titleNode,
            onTap: () => titleNode.requestFocus(),
            onTapOutside: (_) => titleNode.unfocus(),
            onChanged: (title) =>
                context.read<AlarmBloc>().changeField('title', title),
            style: AppTextTheme.label,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(hintText: 'New Alarm'),
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
                onPressed: _save(context),
                icon: const Icon(CupertinoIcons.check_mark))
          ],
        ),
        SliverToBoxAdapter(
            child: SizedBox(
                width: double.infinity,
                height: 300,
                child: BlocBuilder<AlarmBloc, Map<String, dynamic>>(
                  builder: (context, state) {
                    _currentTime = timeParse(state);
                    return TimePicker(
                      key: _timeKey,
                      initialTime: _currentTime,
                      onTimeChanged: (time) {
                        _currentTime = time;
                        timeController.text =
                            DateFormat().add_Hm().format(_currentTime);
                        setState(() {
                          context
                              .read<AlarmBloc>()
                              .changeField('time', time.toIso8601String());
                        });
                      },
                    );
                  },
                ))),
        SliverToBoxAdapter(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(flex: 2, child: Text("Time")),
                      Flexible(
                          child: TextField(
                        style: AppTextTheme.body,
                        keyboardType: TextInputType.datetime,
                        controller: timeController,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(),
                            constraints: BoxConstraints(maxWidth: 80)),
                        focusNode: timeNode,
                        onTap: () => timeNode.requestFocus(),
                        onTapOutside: (_) => timeNode.unfocus(),
                        onChanged: (result) {
                          var timer = result.split(":");
                          var minute =
                              (timer.length == 1) ? "0" : timer.elementAt(1);
                          DateTime time = DateTime(
                              1,
                              1,
                              1,
                              int.tryParse(timer.first) ?? 0,
                              int.tryParse(minute) ?? 0);
                          _timeKey.currentState?.setTime(time);
                          setState(() {
                            context
                                .read<AlarmBloc>()
                                .changeField('time', time.toIso8601String());
                          });
                        },
                        inputFormatters: [Time24hInputFormatter()],
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Repeat on"),
                      Flexible(
                          child: BlocBuilder<AlarmBloc, Map<String, dynamic>>(
                        builder: (context, state) => TextButton(
                            onPressed: _showRepeatSelectionDialog,
                            child: _repeat(state)),
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Ringtone"),
                      Flexible(
                          child: BlocBuilder<AlarmBloc, Map<String, dynamic>>(
                        builder: (context, state) => TextButton(
                            onPressed: _showRingtoneSelectionDialog,
                            child: Text(state['ringTone'] ?? "None")),
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 30, child: Text("Message")),
                TextField(
                  style: AppTextTheme.body,
                  controller: messageController,
                  focusNode: messageNode,
                  onTap: () => messageNode.requestFocus(),
                  onTapOutside: (_) => messageNode.unfocus(),
                  onChanged: (message) {
                    context.read<AlarmBloc>().changeField('message', message);
                  },
                  textAlign: TextAlign.justify,
                  minLines: 1,
                  maxLines: null,
                  maxLength: 180,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                ),
                (_isNew)? const SizedBox(): TextButton(onPressed: _delete(context), child: const Text("Delete"))
              ],
            ),
          ),
        )),
      ],
    );
  }

  VoidCallback _delete(BuildContext context) {
    return () {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: const Text("Delete alarm"),
          content: const Text("Are you sure to delete this alarm?"),
          actions: [
            TextButton(onPressed: () {context.pop();}, child: const Text("Cancel")),
            TextButton(onPressed: () {
              ServerData.deleteAlarm(widget.alarmId);
              context.pop();
              context.pop();
            }, child: const Text("Delete", style: TextStyle(color: AppColors.red)))
          ],
        );
      });
    };
  }
}
