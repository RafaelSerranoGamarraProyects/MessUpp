import 'package:tfg_app/models/group_expense.dart';

class DebtCalculator {
  List<String> friends;
  late List<List<double>> debtMatrix;

  DebtCalculator(this.friends) {
    debtMatrix = List.generate(friends.length, (i) => List<double>.filled(friends.length, 0));
  }

  void recordExpense(GroupExpense groupExpense) {
		var payer = groupExpense.payer;
		var amount = groupExpense.amount;
		var beneficiaries = groupExpense.beneficiaries;

    final payerIndex = friends.indexOf(payer);
    final amountPerPerson = amount / beneficiaries.length;

    for (final beneficiary in beneficiaries) {
      final beneficiaryIndex = friends.indexOf(beneficiary);
      debtMatrix[payerIndex][beneficiaryIndex] += amountPerPerson;
      debtMatrix[beneficiaryIndex][payerIndex] -= amountPerPerson;
    }
  }

List<GroupDebt> calculateDebts() {
  final debts = <GroupDebt>[];

  for (var i = 0; i < friends.length; i++) {
    for (var j = i + 1; j < friends.length; j++) {
      final debt = debtMatrix[i][j];
      if (debt > 0) {
        debts.add(GroupDebt(friends[i], friends[j], debt));
      } else if (debt < 0) {
        debts.add(GroupDebt(friends[j], friends[i], -debt));
      }
    }
  }

  return debts;
}
}

// void main() {
//   final friends = ['Friend1', 'Friend2', 'Friend3'];
//   final calculator = DebtCalculator(friends);

//   calculator.recordExpense('Friend1', ['Friend2', 'Friend3'], 100);
//   calculator.recordExpense('Friend2', ['Friend1'], 50);
//   calculator.recordExpense('Friend3', ['Friend1'], 75);

//   final debts = calculator.calculateDebts();
//   for (final debt in debts) {
//     print(debt);
//   }
// }