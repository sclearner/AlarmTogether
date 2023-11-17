import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key, required this.navigationShell, required this.children});

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.alarm), label: "Alarm", tooltip: "Alarm"),
    const BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings),
        label: "Settings",
        tooltip: "Settings")
  ];

  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: widget.children.length, vsync: this);
    _controller.addListener(() {
      _onTap(context)(_controller.index);
    });
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: _items,
          currentIndex: widget.navigationShell.currentIndex,
          onTap: _onTap(context),
        ),
        body: TabBarView(
          controller: _controller,
          children: widget.children,
        )
    );
  }

  void Function(int) _onTap(BuildContext context) {
    return (int index) {
      setState(() {
        _controller.animateTo(index);
        widget.navigationShell.goBranch(
            index, initialLocation: false);
      });

    };
  }
}