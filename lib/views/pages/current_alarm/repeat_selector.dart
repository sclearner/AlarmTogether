import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class RepeatSelector extends StatefulWidget {
  final List<bool> lastRepeater;

  RepeatSelector({super.key, required this.lastRepeater})
      : assert(lastRepeater.length == 7);

  @override
  State<RepeatSelector> createState() => _RepeatSelectorState();
}

class _RepeatSelectorState extends State<RepeatSelector> {
  late List<bool> _result;

  List<String> _weekdays =
      DateFormat.EEEE().dateSymbols.STANDALONESHORTWEEKDAYS;

  @override
  void initState() {
    _result = widget.lastRepeater;
    super.initState();
  }

  void Function(bool?) _onChange(int i) {
    return (res) {
      setState(() {
        _result[i] = res ?? false;
      });
    };
  }

  VoidCallback _cancel(BuildContext context) {
    return () => context.pop();
  }

  VoidCallback _submit(BuildContext context) {
    return () {
      context.pop(_result);
    };
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: Text("Repeat on"),
      content: SingleChildScrollView(
        child: ListBody(
          children: List<Widget>.generate(7,
              (i) => CheckboxListTile(
                  value: _result[i],
                  title: Text(_weekdays[i]),
                  onChanged: _onChange(i),
              controlAffinity: ListTileControlAffinity.platform,),
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: _cancel(context), child: Text("Cancel")),
        TextButton(onPressed: _submit(context), child: Text("Submit")),
      ],
    );
  }
}
