import 'package:flutter/material.dart';
import 'package:tfg_app/theme/app_theme.dart';
import '../widgets/widgets.dart';

class SpendObjetivesScreen extends StatefulWidget {
	 
	const SpendObjetivesScreen({Key? key}) : super(key: key);
  @override
  State<SpendObjetivesScreen> createState() => _SpendObjetivesScreenState();
}

class _SpendObjetivesScreenState extends State<SpendObjetivesScreen> {
	@override
	Widget build(BuildContext context) {
		return DefaultTabController(
					length: 2,
					child: Scaffold(
						appBar: AppBar(
							title: const Text('Gastos y Objetivos', style: TextStyle(color: Colors.white),),
							bottom: 
								const TabBar(
									labelColor: Colors.white,
									dividerColor: AppTheme.primaryColor,
									unselectedLabelColor: Colors.white,
									indicatorWeight: 3,
									indicatorColor: Colors.white,
									tabs: [
										Tab(text: 'Gastos',icon: Icon(Icons.monetization_on_outlined)),
										Tab(text: 'Objetivos',icon: Icon(Icons.track_changes_outlined),),
									]),
						),
						drawer:  const Drawer(child: MyDrawer()),
						body:  const TabBarView(
								children: [
									ExpensesList(),
									ObjetiveView()
								],
						),
					),
				);
	}
}

