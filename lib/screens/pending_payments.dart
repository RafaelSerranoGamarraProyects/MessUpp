import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class DebtsScreen extends StatelessWidget {
	 
	const DebtsScreen({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context) {
		final debtsprovider = Provider.of<DebtsProvider>(context);
		return  Scaffold(
			appBar: AppBar(title: const Text("Tricount App"),),
			drawer: const Drawer(child: MyDrawer()),
			body: Center(
				 child: Stack(
						children: [
							const Background(),
					 		Column(
							 children: [
							 	Expanded(child:	
							 		SizedBox(
										height: 600,
      							child: ListView.builder(
											itemCount: debtsprovider.userDebts.length,
											itemBuilder: (context, index) =>  CustomCardDebt(debt: debtsprovider.userDebts[index],))
      						),
								),
						 	]
					 	),			
					],	
				),
			)
		);
	}
}

class CustomCardDebt extends StatelessWidget {
  const CustomCardDebt({
    super.key, required this.debt,
  });
	final Debt debt;

  @override
  Widget build(BuildContext context) {
		final usersProvider = Provider.of<UsersProvider>(context);
		String userLogged = "";
		String otherUser = "";
		IconData icon;
		Color color;
		
		if(debt.originUser == usersProvider.user) {
		  userLogged = debt.originUser;
			otherUser = debt.destinationUser;
			icon = Icons.arrow_right_alt;
			color = Colors.red;

		} else{
			userLogged = debt.destinationUser;
			otherUser = debt.originUser;
			icon = Icons.arrow_back_sharp;
			color = Colors.greenAccent;
		}

    return Container(
			padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
			child: Card(
					color: Colors.white.withOpacity(0.4),
					child: Container(
							padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
							alignment: Alignment.center,
							height: 70,
							width: double.infinity,
							child: GestureDetector(	
								onTap: () => Navigator.pushReplacementNamed(context, 'debtDetail', arguments: debt),			
								child: Row(
									children: [
										Text(userLogged,style: const TextStyle(color: Colors.white, fontSize: 20),),
										Icon(icon, color: color,),
										Text(otherUser,style: const TextStyle(color: Colors.white, fontSize: 20),),
									]
								),
							),
					),
				),
		);
  }
}
