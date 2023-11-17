import 'package:alarmtogether/controllers/routes/routes.dart';
import 'package:alarmtogether/models/alarm.dart';
import 'package:alarmtogether/views/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutesHelper {
  static late final router;

  static late int tabCount;

  static final AppRoutesHelper _instance = AppRoutesHelper._internal();

  static AppRoutesHelper get instance => _instance;

  factory AppRoutesHelper() {
    return _instance;
  }

  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();

  static late final TabController? controller;

  Page _getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }

  AppRoutesHelper._internal() {
    final branches = [
      StatefulShellBranch(routes: [
        GoRoute(
            path: AppRoutes.alarm,
            pageBuilder: (context, state) {
              return _getPage(child: AlarmPage(), state: state);
            }),
        GoRoute(
            path: AppRoutes.currentAlarm,
            pageBuilder: (context, state) {
              return _getPage(
                  child: CurrentAlarmPage(
                    alarmId: state.pathParameters[AppRoutes.pathCurrentAlarm]!,
                    alarm: state.extra as Alarm?,
                  ),
                  state: state);
            })
      ]),
      StatefulShellBranch(routes: [
        GoRoute(
            path: AppRoutes.settings,
            pageBuilder: (context, state) {
              return _getPage(child: SettingsPage(), state: state);
            }),
      ])
    ];

    final routes = [
      StatefulShellRoute(
        parentNavigatorKey: parentNavigatorKey,
        branches: branches,
        builder: (context, state, navigationShell) => navigationShell,
        navigatorContainerBuilder: (context, navigationShell, children) {
          return MainPage(
            navigationShell: navigationShell,
            children: children,
          );
        },
      )
    ];

    router = GoRouter(
        navigatorKey: parentNavigatorKey,
        initialLocation: AppRoutes.alarm,
        routes: routes);

    tabCount = branches.length;
  }
}
