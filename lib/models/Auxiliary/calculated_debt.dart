class CalculatedDebt {
  String payer;
  String beneficiaries;
  double amount;

  CalculatedDebt(this.payer, this.beneficiaries, this.amount);
  

    @override
  String toString() {
    return '$beneficiaries owes $payer $amount €';
  }
}