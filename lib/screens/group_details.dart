import 'package:flutter/material.dart';
import 'package:tfg_app/theme/app_theme.dart';
import 'package:tfg_app/widgets/background.dart';

import '../models/models.dart';
// import '../providers/providers.dart';

class GroupDetailsScreen extends StatelessWidget {
	const GroupDetailsScreen({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context) {
		final Group group = ModalRoute.of(context)!.settings.arguments as Group;
		return  DefaultTabController(
				length: 2,
					child: Scaffold(
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
							title: Row(
								children: [
									const ReturnToGroups(),
									Expanded(
										child: TextButton(
											onPressed: () {  },
											child: Column(
											  children: [
											    Text(group.name, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
													const Text("Toca para mas informacion", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic)),
											  ],
											),
										),
									),
									IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert_rounded))
								],
							)
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


class GroupExpenditures extends StatelessWidget {
  const GroupExpenditures({
    super.key,
    required this.group,
  });

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Stack(
				children:  [
					const Background(),
					SafeArea(
						child: Column(
							children:  [
								 ExpendituresList(group: group)	
							],
						 ),
					),
				],
    );
  }
}

class ExpendituresList extends StatelessWidget {
  const ExpendituresList({
    super.key,
    required this.group,
  });

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Container(
									padding: const EdgeInsets.only(top: 5),
									alignment: Alignment.center,
									height: 300,
									child: ListView.builder(
										itemCount: group.transactions.length,
										itemBuilder: (_, index) => CustomTransactionItem(transaction: group.transactions[index])
									),
    );
  }
}

class CustomTransactionItem extends StatelessWidget {
  const CustomTransactionItem({
    super.key,
    required this.transaction,
  });

  final Map<String,dynamic> transaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
			padding: const EdgeInsets.symmetric(horizontal: 10.0),
			child: Card(
					color: Colors.white.withOpacity(0.7),
					margin: const EdgeInsets.symmetric(vertical: 10),
					child: ListTile(
						title: Text(transaction["name"], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),),
						subtitle: Text(" Pagado por: ${transaction["paidBy"]}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),),
						trailing: Text("${transaction["amount"]} €", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
					),
					
				),
		);
  }
}


class ReturnToGroups extends StatelessWidget {
  const ReturnToGroups({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.popAndPushNamed(context, 'groups');
      }, 
      icon: const Icon( Icons.arrow_back, size: 26, color: Colors.white ),
    );
  }
}


class SalaryScreen extends StatelessWidget {
	
	void calcularDeudas(){
		var totalAmount;
		for (var transaction in group.transactions) {
		  totalAmount += transaction["amount"]!;
		}
		
	}

  const SalaryScreen({
    super.key, required this.group, 
  });

	final Group group;
  @override
  Widget build(BuildContext context) {
    return  const Stack(children: [
			  Background()
		 ]);
  }
}