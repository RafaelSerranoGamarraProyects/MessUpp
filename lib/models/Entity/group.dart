import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messup/models/Auxiliary/monetary_transaction.dart';

import '../../utils/utils.dart';

Group groupFromJson(String str) => Group.fromJson(json.decode(str));

String groupToJson(Group data) => json.encode(data.toJson());

class Group {

    Group({
        this.id,
        required this.name,
        required this.creationDate,
        required this.image,
        required this.participants,
        required this.transactions
    });

    String? id;
    String name;
    DateTime creationDate;
    List<String> participants;
    List<MonetaryTransaction> transactions;
    String image;

    factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        name: json["name"],
        creationDate: DateTime.parse(json["creationDate"]),
        participants: json["participants"],
        transactions: json["transactions"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "name" : name,
        "creationDate": creationDate.toIso8601String(),
        "participants": participants,
        "transactions": transactions.map((transaction) => transaction.toJson()).toList(),
        "image": image,
    };

    factory Group.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Group(
      id: snapshot.id,
      name: data?["name"],
      creationDate: DateTime.parse(data?['creationDate']),
      participants: Parser.parseFromListDynamicToListString(data?['participants']) ,
      transactions: Parser.parseToMonetaryTransactionsList(data?['transactions']) ,
      image: data?['image'],

    );
  }

  Map<String, dynamic> toFirestore() {
    return {
        "name" : name,
        "creationDate": creationDate,
        "participants": participants,
        "transactions": transactions,
        "image": image,
    };
  }
  
}