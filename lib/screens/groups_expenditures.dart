import 'package:Messup/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/custom_styles.dart';
import '../utils/utils.dart';

class GroupExpenditures extends StatelessWidget {
  const GroupExpenditures({
    Key? key,
    required this.group,
  }) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ExpendituresList(group: group),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "add_group_expense", arguments: group);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      "Añadir gasto grupal",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ExpendituresList extends StatelessWidget {
  const ExpendituresList({
    Key? key,
    required this.group,
  }) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      alignment: Alignment.center,
      child: ListView.builder(
        itemCount: group.transactions.length,
        itemBuilder: (_, index) {
          final monetaryTransaction = MonetaryTransaction(
            name: group.transactions[index].name,
            payer: group.transactions[index].payer,
            beneficiaries: Parser.parseFromListDynamicToListString(group.transactions[index].beneficiaries),
            amount: group.transactions[index].amount,
          );
          return CustomTransactionItem(transaction: monetaryTransaction);
        },
      ),
    );
  }
}
