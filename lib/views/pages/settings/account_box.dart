import 'package:alarmtogether/views/templates/color/colors.dart';
import 'package:flutter/material.dart';

class AccountBox extends StatelessWidget {
  const AccountBox({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.account_circle, size: 80),
          Text('Login to sync your account.'),
        ],
      ),
    );
  }
}