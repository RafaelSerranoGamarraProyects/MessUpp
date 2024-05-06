import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../theme/custom_styles.dart';

class CustomTransactionItem extends StatelessWidget {
  const CustomTransactionItem({
    super.key,
    required this.transaction,
  });

  final MonetaryTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
			padding: const EdgeInsets.symmetric(horizontal: 10.0),
			child: Card(
					color: Colors.white,
					margin: const EdgeInsets.symmetric(vertical: 10),
					child: ListTile(
						title: Text(transaction.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textColorSecundary),),
						subtitle: Text(" Pagado por: ${transaction.payer}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppTheme.secondaryBlue),),
						trailing: Text("${transaction.amount} €", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.textColorSecundary)),
					),
				),
		);
  }
}