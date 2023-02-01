import 'package:flutter/material.dart';
import 'package:tfg_app/screens/screens.dart';
import 'routers_export.dart';


class AppRoutes {
  static const initialRoute = 'login';
  static final menuOptions = <RouteOption>[
    RouteOption(
        route: 'spendsAndObjetives',
        screen: const SpendObjetivesScreen()),
		RouteOption(
        route: 'home',
        screen: const SpendObjetivesScreen()),
		RouteOption(
        route: 'expenditureDetail',
        screen: const ExpenditureScreen()),
		RouteOption(
        route: 'groups',
        screen: const GroupsScreen()),
    RouteOption(
        route: 'login',
        screen: const LoginScreen()),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    
    for (var option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }
    return appRoutes;
  }
}
