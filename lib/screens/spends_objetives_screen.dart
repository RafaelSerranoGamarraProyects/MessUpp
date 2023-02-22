import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfg_app/providers/providers.dart';
import '../widgets/widgets.dart';

class SpendObjetivesScreen extends StatefulWidget {
	 
	const SpendObjetivesScreen({Key? key}) : super(key: key);
  @override
  State<SpendObjetivesScreen> createState() => _SpendObjetivesScreenState();
}

class _SpendObjetivesScreenState extends State<SpendObjetivesScreen> {
	@override
	Widget build(BuildContext context) {
		
		final userProvider = Provider.of<UsersProvider>(context);
		return  userProvider.user == "" ? const CircularProgressIndicator()
			: DefaultTabController(
					length: 2,
					child: Scaffold(
						appBar: AppBar(
							title: const Text('Tricount App'),
							bottom: 
								const TabBar(
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

