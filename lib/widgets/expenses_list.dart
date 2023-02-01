import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfg_app/models/expenditure.dart';
import 'package:tfg_app/theme/app_theme.dart';

import '../providers/providers.dart';
import 'widgets.dart';

class ExpensesList extends StatefulWidget {
	//final List<Expenditure> expenses;
	const ExpensesList({super.key, /* required this.expenses */});

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
	@override
	Widget build(BuildContext context) {
		/* final expensesProvider = Provider.of<ExpensesProvider>(context); */
		final size = MediaQuery.of(context).size;
		return ChangeNotifierProvider(
			create: (_) => ExpensesProvider(), lazy: false,
			child: Stack(
				children: [
					const Background(),
						 Column(
							 children: const [
								 Expanded(child: _ListOfItems()),
								 TotalSpentBar()
							 ],
						 ),
						Container(
							padding: const EdgeInsets.only(right: 15),
							alignment: Alignment.bottomCenter,
							height: size.height - 220,
							width: size.width,
							child: const PopUpFormAddExpenditure()
							/* ElevatedButton(
								style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: Colors.grey, minimumSize: const Size(50,50)),
								onPressed: () {	
									setState(() {});
								},
								child: const Icon(Icons.add, size: 25,color: Colors.black),
							), */
						),				
					],
			),
		);	
	}
}

class TotalSpentBar extends StatelessWidget {
  const TotalSpentBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
		final expensesProvider = Provider.of<ExpensesProvider>(context);
    return Container(
				height: 60,
				color: AppTheme.primaryColor,
     child: Row(
				crossAxisAlignment: CrossAxisAlignment.center,
				mainAxisAlignment: MainAxisAlignment.start,
				children:   [
					Padding(
					  padding: const EdgeInsets.only(left: 10),
					  child: Row(
					    children: [
					      const Text("Total gastado este mes: ",
									style: TextStyle(color:Colors.white, fontSize: 20,fontWeight: FontWeight.normal),
									),
								Text("${expensesProvider.getTotalSpend()}€",
									style: const TextStyle(color:Colors.white, fontSize: 25,fontWeight: FontWeight.bold)
								,)
					    ],
					  ),
					),],),
    );
  }
}



class _ListOfItems extends StatelessWidget {
	//final List<Expenditure> expenses;
  const _ListOfItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
		final expensesProvider = Provider.of<ExpensesProvider>(context);
    return SizedBox(
			height: 600,
      child: ListView.builder(
					itemCount: expensesProvider.monthlyExpenses.length,
					itemBuilder: (context, index) =>  _CustomItem(expenditure: expensesProvider.monthlyExpenses[index])
      ),
    );
  }
}

class _CustomItem extends StatelessWidget {
	final Map<String, IconData> categoryMap ={
		"Alimentacion" : Icons.fastfood_rounded,
		"Ocio" : Icons.sports_esports_rounded,
		"Viaje" : Icons.travel_explore_outlined
	};
	final Expenditure expenditure;
	
   _CustomItem({
    Key? key, required this.expenditure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Card(
			margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
			color: Colors.white.withOpacity(0.9),
      child: ListTile(
				onTap: () => Navigator.pushNamed(context, 'expenditureDetail', arguments: expenditure),
        leading: Icon(categoryMap[expenditure.category],color: Colors.black,),
        title: Text(expenditure.description,style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
        subtitle: Text('${expenditure.date.day}-${expenditure.date.month}-${expenditure.date.year}'),
				trailing: Text("${expenditure.amount} €",style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
      ),);
  }
}