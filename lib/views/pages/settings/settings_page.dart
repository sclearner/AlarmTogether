import 'package:alarmtogether/views/pages/settings/account_box.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Settings"),
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: AccountBox()
          )
        ],
      );
  }
}