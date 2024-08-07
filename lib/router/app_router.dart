import 'package:messup/router/routers_export.dart';
import 'package:flutter/material.dart';
import 'package:messup/screens/screens.dart';

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
        route: 'group_details',
        screen: const GroupDetailsScreen()),
    RouteOption(
        route: 'create_group',
        screen: const GroupCreation()),
    RouteOption(
        route: 'add_group_expense',
        screen: const AddGroupExpense()),
	RouteOption(
        route: 'expenditureDetail',
        screen: const ExpenditureScreen()),
    RouteOption(
        route: 'debtDetail',
        screen: const DebtDetailScreen()),
            RouteOption(
        route: 'group_participants',
        screen: const ParticipantsScreen()),
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
