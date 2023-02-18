import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Objetive objetiveFromJson(String str) => Objetive.fromJson(json.decode(str));

String objetiveToJson(Objetive data) => json.encode(data.toJson());

class Objetive {
    Objetive({
        required this.date,
        required this.amount,
        required this.description,
        required this.isAchived,
        required this.user
    });

    
    DateTime date;
    double amount;
    String description;
    bool isAchived;
    String user;

    factory Objetive.fromJson(Map<String, dynamic> json) => Objetive(
        
        date: DateTime.parse(json["date"]),
        amount: json["amount"]?.toDouble(),
        description: json["description"],
        isAchived: json["isAchived"],
        user: json["user"]
    );

    Map<String, dynamic> toJson() => {
        
        "date": date.toIso8601String(),
        "amount": amount,
        "description": description,
        "isAchived": isAchived,
        "user" : user
    };


    factory Objetive.fromFirestore(
        DocumentSnapshot<Map<String, dynamic>> snapshot,
        SnapshotOptions? options,
    ) {
    final data = snapshot.data();
    return Objetive(
        date: DateTime.parse(data?['date']),
        amount: double.parse('${data?["amount"]}'),
        description: data?['description'],
        user: data?['user'],
        isAchived: data?['isAchived'],
    );
    }

  Map<String, dynamic> toFirestore() {
    return {
        "date": date,
        "amount": amount,
        "description": description,
        "isAchived": isAchived,
        "user": user,
    };
  }
		
}
