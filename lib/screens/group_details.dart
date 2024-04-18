import 'package:Messup/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:Messup/theme/app_theme.dart';
import '../models/models.dart';
import 'screens.dart';


class GroupDetailsScreen extends StatelessWidget {
	const GroupDetailsScreen({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context) {
		final Group group = ModalRoute.of(context)!.settings.arguments as Group;
		return  DefaultTabController(
				length: 2,
					child: Scaffold(
						resizeToAvoidBottomInset: false,
						appBar: AppBar(
							bottom: const TabBar(
							unselectedLabelColor: Colors.white,
							labelColor: Colors.white,
							dividerColor: AppTheme.primaryColor,
							indicatorWeight: 3,
							indicatorColor: Colors.white,
							tabs: [
								Tab(text: 'Gastos',icon: Icon(Icons.attach_money_rounded)),
								Tab(text: 'Saldos',icon: Icon(Icons.wallet),),
							]
						),
							title: GroupsScreenHeader(group: group)
						),
						 body :  TabBarView(
							children: [
								GroupExpenditures(group: group,),
								SalaryScreen(group: group)
							],) 			
					),
				);
	}
}

class GroupsScreenHeader extends StatelessWidget {
  const GroupsScreenHeader({
    super.key,
    required this.group,
  });
  final Group group;

  @override
  Widget build(BuildContext context) {
    return Row(
    	children: [
    		const ReturnToButton(route: "groups"),
    		Expanded(
    			child: TextButton(
    				onPressed: () {},
    				child: Text(group.name, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
    			),
    		),
    		IconButton(onPressed: () {
					 Navigator.pushReplacementNamed(context, 'group_participants', arguments: group);
				}, icon: const Icon(Icons.people_alt))
    	],
    );
  }
}


