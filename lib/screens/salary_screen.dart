
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
		DebtCalculator calculator = DebtCalculator(group.participants);
    return   Stack(children: [
			  const Background(),
				Column(children: [
						Expanded(
							child: ListView.builder(
								itemCount: 5,
								itemBuilder: (context, index) => Text("Deuda ${index + 1}"),
							),
						),
					],),
				
		 ]);
  }
}