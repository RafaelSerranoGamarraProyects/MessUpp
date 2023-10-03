
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

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