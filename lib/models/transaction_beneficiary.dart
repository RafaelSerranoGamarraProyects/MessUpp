class TransactionBeneficiary {
  final String name;
  bool isBeneficiary;

  TransactionBeneficiary({required this.name, required this.isBeneficiary});
}

List<TransactionBeneficiary> mapStringsToBeneficiaries(List<String> strings) {
  return strings.map((string) => TransactionBeneficiary(name: string, isBeneficiary: false)).toList();
}
