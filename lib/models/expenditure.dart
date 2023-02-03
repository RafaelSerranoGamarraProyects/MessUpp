// To parse this JSON data, do
//
//     final expenditure = expenditureFromJson(jsonString);

import 'dart:convert';

Expenditure expenditureFromJson(String str) => Expenditure.fromJson(json.decode(str));

String expenditureToJson(Expenditure data) => json.encode(data.toJson());

class Expenditure {
    Expenditure({
        required this.date,
        required this.amount,
        required this.category,
        required this.description,
        required this.image,
    });

    DateTime date;
    double amount;
    String category;
    String description;
    String image;

    factory Expenditure.fromJson(Map<String, dynamic> json) => Expenditure(
        date: DateTime.parse(json["date"]),
        amount: double.parse('${json["amount"]}'),
        category: json["category"],
        description: json["description"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "amount": amount,
        "category": category,
        "description": description,
        "image": image,
    };

  
}
