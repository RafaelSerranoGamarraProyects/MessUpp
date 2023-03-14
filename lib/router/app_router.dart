import 'package:flutter/material.dart';
import 'package:tfg_app/screens/screens.dart';
import 'routers_export.dart';


class AppRoutes {
  static String initialRoute = 'login';
  static final menuOptions = <RouteOption>[
		RouteOption(
        route: 'home',
        screen: const SpendObjetivesScreen()),
    RouteOption(
        route: 'spendsAndObjetives',
        screen: const SpendObjetivesScreen()),
    RouteOption(
        route: 'debts',
        screen: const DebtsScreen()),
		RouteOption(
        route: 'groups',
        screen: const GroupScreen()),
		RouteOption(
        route: 'expenditureDetail',
        screen: const ExpenditureScreen()),
    RouteOption(
        route: 'debtDetail',
        screen: const DebtDetailScreen()),
    RouteOption(
        route: 'login',
        screen: const LoginScreen()),
    RouteOption(
        route: 'register',
        screen: const RegisterScreen()),

  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    
    for (var option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }
    return appRoutes;
  }
}
