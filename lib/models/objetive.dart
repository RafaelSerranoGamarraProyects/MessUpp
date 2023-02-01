import 'dart:convert';

Objetive objetiveFromJson(String str) => Objetive.fromJson(json.decode(str));

String objetiveToJson(Objetive data) => json.encode(data.toJson());

class Objetive {
    Objetive({
        required this.id,
        required this.date,
        required this.amount,
        required this.description,
        required this.isAchived,
    });

    String id;
    DateTime date;
    double amount;
    String description;
    bool isAchived;

    factory Objetive.fromJson(Map<String, dynamic> json) => Objetive(
        id: json["_id"],
        date: DateTime.parse(json["date"]),
        amount: json["amount"]?.toDouble(),
        description: json["description"],
        isAchived: json["isAchived"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "date": date.toIso8601String(),
        "amount": amount,
        "description": description,
        "isAchived": isAchived,
    };
		
}
