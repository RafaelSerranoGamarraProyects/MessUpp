import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tfg_app/providers/providers.dart';
import 'package:tfg_app/theme/app_theme.dart';
import '../utils/utils.dart';
import 'widgets.dart';


class ObjetiveView extends StatelessWidget {
	const ObjetiveView({super.key});

	@override
	Widget build(BuildContext context) {
		return const Stack(
			children: [
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
    final objetivesProvider = Provider.of<ObjetivesProvider>(context);
    if(objetivesProvider.monthlyObjetive.user == "") return const AddObjetive();

    return const Column(
			children: [
				OverViewGraph(),
			  Details()
			],
    );
  }
}

class AddObjetive extends StatelessWidget {
  const AddObjetive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 400,
            width: double.infinity,
            child: const NoObjetiveCard()),
        ],
      )
    );
  }
}

class NoObjetiveCard extends StatelessWidget {
  const NoObjetiveCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.track_changes_rounded, color: Colors.white, size: 120, weight: 20,),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text("¿No ha establecido aún su objetivo?", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
        ),
        PopUpFormAddObjetive()
      ],
    );
  }
}

class _ObjetiveDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final objetivesProvider = Provider.of<ObjetivesProvider>(context);
    return Container(
      height: 100,
      padding: const EdgeInsets.only(top: 15, bottom: 10, right: 15, left: 15),
      child: Text(objetivesProvider.monthlyObjetive.description,
       style: const TextStyle(color: Colors.white, fontSize: 18, overflow: TextOverflow.clip),),
    );
  }
}

class _ObjetiveTitle extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final objetivesProvider = Provider.of<ObjetivesProvider>(context);
    var formatedMonth = DateRefactoring.months[ DateFormat('MMM').format(DateTime(0, objetivesProvider.monthlyObjetive.date.month)).toString() ];
    
    return Container(
      padding: const EdgeInsets.only(top : 20, bottom: 10, left: 8, right: 8),
      child: Text('Objetivo del Mes de $formatedMonth',
       style: const TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),),
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
    	height: 400,
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
    
    return SizedBox(
      height: 300,
      width: double.infinity,
			child: Column(
        children: [
				  _ObjetiveTitle(),
				  _ObjetiveDescription(),
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
    var percentage = (expensesProvider.getTotalSpend() / objetivesProvider.monthlyObjetive.amount) * 100;
    
    return  Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Column(
        children: [
          Text("${expensesProvider.getTotalSpend().toStringAsFixed(2)} € / ${objetivesProvider.monthlyObjetive.amount.toStringAsFixed(2)} €", style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
          percentage > 100
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cancel_sharp, color: AppTheme.errorColor,),
                Text("${percentage.toStringAsFixed(2)}%  Superado", style: const TextStyle(color: AppTheme.errorColor, fontSize: 18, fontWeight: FontWeight.normal),),
              ],
          )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check, color: Colors.greenAccent.shade400,),
                Text("${percentage.toStringAsFixed(2)}%  Cumpliendo", style:  TextStyle(color: Colors.greenAccent.shade400, fontSize: 18, fontWeight: FontWeight.normal),),
              ],
          ),
        
        ],
      )
    );
  }
}





