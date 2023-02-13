import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfg_app/models/expenditure.dart';
import 'package:tfg_app/theme/app_theme.dart';
import 'package:tfg_app/utils/categories_options.dart';

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
		final size = MediaQuery.of(context).size;
		return Stack(
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
					),				
				],
		);	
	}
}

class TotalSpentBar extends StatefulWidget {
  const TotalSpentBar({
    Key? key,
  }) : super(key: key);


  @override
  State<TotalSpentBar> createState() => _TotalSpentBarState();
}

class _TotalSpentBarState extends State<TotalSpentBar> {
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
								Text("${expensesProvider.getTotalSpend().toStringAsFixed(2)}€",
									style: const TextStyle(color:Colors.white, fontSize: 25,fontWeight: FontWeight.bold)
								,)
					    ],
					  ),
					),],),
    );
  }
}



class _ListOfItems extends StatefulWidget {
	//final List<Expenditure> expenses;
  const _ListOfItems({
    Key? key,
  }) : super(key: key);

  @override
  State<_ListOfItems> createState() => _ListOfItemsState();
}

class _ListOfItemsState extends State<_ListOfItems> {
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

class _CustomItem extends StatefulWidget {
	final Expenditure expenditure;
	
   const _CustomItem({
    Key? key, required this.expenditure,
  }) : super(key: key);

  @override
  State<_CustomItem> createState() => _CustomItemState();
}

class _CustomItemState extends State<_CustomItem> {
	final Map<String, IconData> categoryMap = CategoriesOptions.categoryIconMap;

  @override
  Widget build(BuildContext context) {
    return  Card(
			margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
			color: Colors.white.withOpacity(0.9),
      child: ListTile(
				onTap: () => Navigator.pushReplacementNamed(context, 'expenditureDetail', arguments: widget.expenditure),
        leading: Icon(categoryMap[widget.expenditure.category],color: Colors.black,),
        title: Text(widget.expenditure.description,style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
        subtitle: Text('${widget.expenditure.date.day}-${widget.expenditure.date.month}-${widget.expenditure.date.year}'),
				trailing: Text("${widget.expenditure.amount.toStringAsFixed(2)} €", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
      ),);
  }
}