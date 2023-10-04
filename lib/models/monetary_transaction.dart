import 'dart:convert';

import '../utils/utils.dart';

MonetaryTransaction transactionFromJson(String str) => MonetaryTransaction.fromJson(json.decode(str));
String transactionToJson(MonetaryTransaction data) => json.encode(data.toJson());

class MonetaryTransaction {
  String name;
  String payer;
  List<String> beneficiaries;
  double amount;


  MonetaryTransaction({
    required this.name,
    required this.payer,
    required this.beneficiaries,
    required this.amount
  });

  factory MonetaryTransaction.fromJson(Map<String, dynamic> json) => MonetaryTransaction(
    name: json["name"],
    payer: json["payer"],
    beneficiaries: Parser.parseFromListDynamicToListString(json["beneficiaries"]) ,
    amount:  double.parse('${json["amount"]}'),
  );

    Map<String, dynamic> toJson() => {
        "name": name,
        "payer": payer,
        "beneficiaries": beneficiaries,
        "amount": amount,
    };

  Map<String, dynamic> toFirestore() {
    return {
        "name": name,
        "payer": payer,
        "beneficiaries": beneficiaries,
        "amount": amount,

    };
  }


}