import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tfg_app/providers/providers.dart';
import 'package:tfg_app/utils/dates_utils.dart';
import 'widgets.dart';


class ObjetiveView extends StatelessWidget {
	const ObjetiveView({super.key});

	@override
	Widget build(BuildContext context) {
		return Stack(
			children: const  [
				Background(),
				ObjetiveScreenBody()
			]);	
	}
}

class ObjetiveScreenBody extends StatelessWidget {
	const ObjetiveScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
			children: const [
				OverViewGraph(),
				//Divider(color: Colors.white, thickness: 2,),
			  Details()
			],
    );
  }
}

class _ObjetiveDescription extends StatelessWidget {
  const _ObjetiveDescription({
    required this.objetivesProvider,
  });

  final ObjetivesProvider objetivesProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Text(objetivesProvider.monthlyObjetive.description,
       style: const TextStyle(color: Colors.white, fontSize: 18, overflow: TextOverflow.clip),),
    );
  }
}

class _ObjetiveTitle extends StatelessWidget {
  const _ObjetiveTitle({
    required this.objetivesProvider,
  });

  final ObjetivesProvider objetivesProvider;
  @override
  Widget build(BuildContext context) {
    var formatedMonth = DateRefactoring.months[ DateFormat('MMM').format(DateTime(0, objetivesProvider.monthlyObjetive.date.month)).toString() ];
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical : 10, horizontal: 8),
      child: Text('Objetivo del Mes de $formatedMonth',
       style: const TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.bold),),
    );
  }
}

class Details extends StatelessWidget {
  const Details({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
			padding: const EdgeInsets.all(8),
    	height: 380,
    	width: double.infinity,
			child: Column(
				children: [
					Container(
						alignment: Alignment.topLeft,
						padding: const EdgeInsets.all(8),
						child: const Text("Detalles", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
            ),
					const ListCategoryCards(),
				],
			),
    );
  }
}

class OverViewGraph extends StatelessWidget {  
	const OverViewGraph({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
		final objetivesProvider = Provider.of<ObjetivesProvider>(context);
    return SizedBox(
      height: 270,
			child: Column(
        children: [
				  _ObjetiveTitle(objetivesProvider: objetivesProvider),
				  _ObjetiveDescription(objetivesProvider: objetivesProvider),
          const _ActualProgress(),
				  const HorizontalBarChart()
			  ]
      ),
    );
  }
}

class _ActualProgress extends StatelessWidget {
  const _ActualProgress();

  @override
  Widget build(BuildContext context) {
    final expensesProvider = Provider.of<ExpensesProvider>(context);
    final objetivesProvider = Provider.of<ObjetivesProvider>(context);
    //TODO : SABER HACER EL PUTO PORCENTAJE
    var percentage = (expensesProvider.getTotalSpend() / expensesProvider.totalPreviousMonth) * 100;
    
    return  Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Column(
        children: [
          Text("${expensesProvider.getTotalSpend().toStringAsFixed(2)} € / ${objetivesProvider.monthlyObjetive.amount.toStringAsFixed(2)} €", style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
          percentage > 100
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_upward_rounded, color: Colors.redAccent,),
                Text("${percentage.toStringAsFixed(2)} % / Anterior Mes", style: const TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.normal),),
              ],
          )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_downward_rounded, color: Colors.greenAccent,),
                Text("${percentage.toStringAsFixed(2)} % / Anterior Mes", style: const TextStyle(color: Colors.greenAccent, fontSize: 16, fontWeight: FontWeight.normal),),
              ],
          ),
        
        ],
      )
    );
  }
}





