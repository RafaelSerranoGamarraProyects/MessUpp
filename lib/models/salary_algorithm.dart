import 'models.dart';

class DebtCalculator {
  List<String> friends;
  late List<List<double>> debtMatrix;

  DebtCalculator(this.friends) {
    debtMatrix = List.generate(friends.length, (i) => List<double>.filled(friends.length, 0));
  }

	void recordTransactions(List<MonetaryTransaction> transactions){
		for(var item in transactions){
			recordExpense(item);
		}
	}

  void recordExpense(MonetaryTransaction groupExpense) {
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

  List<CalculatedDebt> calculateDebts() {
    final debts = <CalculatedDebt>[];

    for (var i = 0; i < friends.length; i++) {
      for (var j = i + 1; j < friends.length; j++) {
        final debt = debtMatrix[i][j];
        if (debt > 0) {
          debts.add(CalculatedDebt(friends[i], friends[j], debt));
        } else if (debt < 0) {
          debts.add(CalculatedDebt(friends[j], friends[i], -debt));
        }
      }
    }

    return debts;
  }
}