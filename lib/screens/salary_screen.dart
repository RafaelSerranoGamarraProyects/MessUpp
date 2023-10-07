
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class SalaryScreen extends StatelessWidget {
	
  const SalaryScreen({
    super.key, required this.group, 
  });

	final Group group;
  @override
  Widget build(BuildContext context) {
		DebtCalculator calculator = DebtCalculator(group.participants, group.transactions);
		var debtsList = calculator.calculateDebts();
    return   Stack(children: [
			  const Background(),
				Column(children: [
						Expanded(
							child: ListView.builder(
								itemCount: debtsList.length,
								itemBuilder: (context, index) => CalculatedDebtCard(calculatedDebt: debtsList[index]),
							),
						),
					],),
				
		 ]);
  }
}

