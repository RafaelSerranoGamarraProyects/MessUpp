// To parse this JSON data, do
//
//     final expenditure = expenditureFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Expenditure expenditureFromJson(String str) => Expenditure.fromJson(json.decode(str));

String expenditureToJson(Expenditure data) => json.encode(data.toJson());

class Expenditure {
    Expenditure({
        this.id,
        required this.date,
        required this.amount,
        required this.category,
        required this.description,
        required this.image,
        required this.user
    });

    String? id;
    DateTime date;
    double amount;
    String category;
    String description;
    String image;
    String user;

    factory Expenditure.fromJson(Map<String, dynamic> json) => Expenditure(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        amount: double.parse('${json["amount"]}'),
        category: json["category"],
        description: json["description"],
        image: json["image"],
        user: json["user"]
    );

    Map<String, dynamic> toJson() => {
        "date"       : date.toIso8601String(),
        "amount"     : amount,
        "category"   : category,
        "description": description,
        "image"      : image,
        "user"       : user
    };


  factory Expenditure.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Expenditure(
      id: snapshot.id,
      date: DateTime.parse(data?['date']),
      amount: double.parse('${data?["amount"]}'),
      category: data?['category'],
      description: data?['description'],
      image: data?['image'],
      user: data?['user'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
        "date": date,
        "amount": amount,
        "description": description,
        "category": category,
        "image": image,
        "user": user,
    };
  }
  
}
