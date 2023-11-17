import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class RingtoneSelector extends StatefulWidget {
  final String? lastRingtone;

  RingtoneSelector({super.key, required this.lastRingtone});

  @override
  State<RingtoneSelector> createState() => _RingtoneSelectorState();
}

class _RingtoneSelectorState extends State<RingtoneSelector> {

  final List<String?> ringTones = [null, for (var i = 1; i <= 100; i++) "Ringtone $i"];

  @override
  void initState() {
    _result = widget.lastRingtone;
    super.initState();
  }

  VoidCallback _cancel(BuildContext context) {
    return () => context.pop();
  }

  VoidCallback _submit(BuildContext context) {
    return () {
      context.pop(_result);
    };
  }

  String? _result;

  void _onChanged(String? e) {
    setState(() {
        _result = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: Text("Select ringtone"),
      content: SingleChildScrollView(
          child: Column(
        children: ringTones
            .map((e) => RadioListTile<String?>(
                value: e,
                groupValue: _result,
                selected: e == _result,
                onChanged: _onChanged,
                title: Text(e ?? "None")))
            .toList(),
      )),
      actions: [
        TextButton(onPressed: _cancel(context), child: Text("Cancel")),
        TextButton(onPressed: _submit(context), child: Text("Submit")),
      ],
    );
  }
}
