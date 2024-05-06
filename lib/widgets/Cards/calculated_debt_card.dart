import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../theme/custom_styles.dart';

class CalculatedDebtCard extends StatelessWidget {
  const CalculatedDebtCard({
    super.key,
    required this.calculatedDebt,
  });

  final CalculatedDebt calculatedDebt;

  @override
  Widget build(BuildContext context) {
    return Padding(
			padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
			child: Card(
				color: Colors.white,
				child: Row(children: [
					Column(
							crossAxisAlignment: CrossAxisAlignment.center,
						children: [
							_CustomCalculatedDebtCardText(text: calculatedDebt.beneficiaries),
							const Text("debe a", style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic)),
							_CustomCalculatedDebtCardText(text: calculatedDebt.payer),
							]
					),
					const Spacer(),
					Padding(
							padding: const EdgeInsets.only(right: 25.0),
							child: Text("${calculatedDebt.amount} €", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28, fontStyle: FontStyle.italic),),
						)
				],),),
		);
  }
}

class _CustomCalculatedDebtCardText extends StatelessWidget {
  const _CustomCalculatedDebtCardText({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
		final usersProvider = Provider.of<UsersProvider>(context);
		var displayedText = text == usersProvider.userLogged!.email ? '${usersProvider.userLogged!.getUserName} (Yo)' : text;
    return Padding(
			padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
			child: Text(displayedText, style: const TextStyle(color: AppTheme.secondaryBlue, fontSize: 18, fontWeight: FontWeight.bold),),
		);
  }
}