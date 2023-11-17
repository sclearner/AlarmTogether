import 'package:alarmtogether/controllers/physics/item_physics.dart';
import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  final DateTime? initialTime;
  final double size;
  final void Function(DateTime)? onTimeChanged;

  const TimePicker(
      {super.key, this.initialTime, this.size = 100, this.onTimeChanged});

  @override
  State<TimePicker> createState() => TimePickerState();
}

class TimePickerState extends State<TimePicker> {
  late final ScrollController _hourController;
  late final ScrollController _minuteController;

  late DateTime _lastTime;

  get _currentTime => DateTime(1, 1, 1, _currentIndex(_hourController.offset),
      _currentIndex(_minuteController.offset));

  int _currentIndex(double offset) {
    return (offset / widget.size).round();
  }

  void _onScrollChange() {
    if (_currentTime != _lastTime) {
      if (widget.onTimeChanged != null) widget.onTimeChanged!(_currentTime);
      setState(() {
        _lastTime = _currentTime;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    DateTime time = widget.initialTime ?? DateTime.now();
    _hourController =
        ScrollController(initialScrollOffset: time.hour * widget.size);
    _minuteController =
        ScrollController(initialScrollOffset: time.minute * widget.size);
    _lastTime = time;
    _hourController.addListener(_onScrollChange);
    _minuteController.addListener(_onScrollChange);
  }

  void setTime(DateTime time) {
    setState(() {
      _lastTime = time;
      _hourController.jumpTo(time.hour * widget.size);
      _minuteController.jumpTo(time.minute * widget.size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ItemListView(
          size: widget.size,
          count: 24,
          controller: _hourController,
          full: false,
        ),
        SizedBox(
          width: widget.size * 0.3,
          child: Text(
            ":",
            style: TextStyle(fontSize: widget.size * 0.5),
            textAlign: TextAlign.center,
          ),
        ),
        _ItemListView(
            size: widget.size, count: 60, controller: _minuteController)
      ],
    );
  }
}

class _ItemListView extends StatefulWidget {
  final double size;
  final int count;
  final ScrollController controller;
  final bool full;

  const _ItemListView(
      {required this.size,
      required this.count,
      required this.controller,
      this.full = true});

  @override
  State<_ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<_ItemListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
          border: Border.all(
            width: (widget.size * 0.01).clamp(1, 6),
          ),
          borderRadius: BorderRadius.circular(widget.size * 0.25)),
      child: ListView.builder(
        itemExtent: widget.size,
        cacheExtent: widget.size * 3,
        controller: widget.controller,
        physics: ItemScrollPhysics(widget.size),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) => Container(
          width: widget.size,
          height: widget.size,
          alignment: Alignment.center,
          child: Text(
            (index < 10 && widget.full) ? "0$index" : "$index",
            style: TextStyle(fontSize: widget.size * 0.5),
          ),
        ),
        itemCount: widget.count,
      ),
    );
  }
}
