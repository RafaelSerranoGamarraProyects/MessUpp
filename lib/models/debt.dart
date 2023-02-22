import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

Debt debtFromJson(String str) => Debt.fromJson(json.decode(str));

String debtToJson(Debt data) => json.encode(data.toJson());

class Debt {

    Debt({
        this.id,
        required this.date,
        required this.amount,
        required this.destinationUser,
        required this.originUser
    });

    String? id;
    DateTime date;
    String destinationUser;
    String originUser;
    double amount;

    factory Debt.fromJson(Map<String, dynamic> json) => Debt(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        destinationUser: json["destinationUser"],
        originUser: json["originUser"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "creationDate": date.toIso8601String(),
        "destinationUser": destinationUser,
        "originUser": originUser,
        "amount": amount,
    };


    factory Debt.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Debt(
      id: snapshot.id,
      date: DateTime.parse(data?['date']),
      destinationUser: data?['destinationUser'],
      originUser: data?['originUser'],
      amount: data?['amount'],

    );
  }

  Map<String, dynamic> toFirestore() {
    return {
        "date": date,
        "destinationUser": destinationUser,
        "originUser": originUser,
        "amount": amount,
    };
  }
  
}
