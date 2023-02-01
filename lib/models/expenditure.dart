// To parse this JSON data, do
//
//     final expenditure = expenditureFromJson(jsonString);

import 'dart:convert';

Expenditure expenditureFromJson(String str) => Expenditure.fromJson(json.decode(str));

String expenditureToJson(Expenditure data) => json.encode(data.toJson());

class Expenditure {
    Expenditure({
        required this.id,
        required this.date,
        required this.amount,
        required this.category,
        required this.description,
        required this.image,
        required this.v,
    });

    String id;
    DateTime date;
    double amount;
    String category;
    String description;
    String image;
    int v;

    factory Expenditure.fromJson(Map<String, dynamic> json) => Expenditure(
        id: json["_id"],
        date: DateTime.parse(json["date"]),
        amount: json["amount"],
        category: json["category"],
        description: json["description"],
        image: json["image"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "date": date.toIso8601String(),
        "amount": amount,
        "category": category,
        "description": description,
        "image": image,
        "__v": v,
    };
}
