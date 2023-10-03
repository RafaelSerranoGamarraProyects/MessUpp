
class GroupExpense {
  String payer;
  List<String> beneficiaries;
  double amount;

  GroupExpense(this.payer, this.beneficiaries, this.amount);

}

class GroupDebt {
  String payer;
  String beneficiaries;
  double amount;

  GroupDebt(this.payer, this.beneficiaries, this.amount);
}