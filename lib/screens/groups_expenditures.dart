import 'package:flutter/material.dart';

import '../models/models.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';

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
										itemBuilder: (_, index) {
                      final monetaryTransaction = MonetaryTransaction(name: group.transactions[index].name,
                        payer: group.transactions[index].payer,
                        beneficiaries: Parser.parseFromListDynamicToListString(group.transactions[index].beneficiaries),
                        amount: group.transactions[index].amount
                      );
                      return CustomTransactionItem(transaction: monetaryTransaction);
                    }
									),
    );
  }
}

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
					color: Colors.white.withOpacity(0.7),
					margin: const EdgeInsets.symmetric(vertical: 10),
					child: ListTile(
						title: Text(transaction.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),),
						subtitle: Text(" Pagado por: ${transaction.payer}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),),
						trailing: Text("${transaction.amount} €", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
					),
				),
		);
  }
}