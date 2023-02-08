import 'dart:convert';

Objetive objetiveFromJson(String str) => Objetive.fromJson(json.decode(str));

String objetiveToJson(Objetive data) => json.encode(data.toJson());

class Objetive {
    Objetive({
        required this.date,
        required this.amount,
        required this.description,
        required this.isAchived,
        required this.userId
    });

    
    DateTime date;
    double amount;
    String description;
    bool isAchived;
    String userId;

    factory Objetive.fromJson(Map<String, dynamic> json) => Objetive(
        
        date: DateTime.parse(json["date"]),
        amount: json["amount"]?.toDouble(),
        description: json["description"],
        isAchived: json["isAchived"],
        userId: json["user"]
    );

    Map<String, dynamic> toJson() => {
        
        "date": date.toIso8601String(),
        "amount": amount,
        "description": description,
        "isAchived": isAchived,
        "user" : userId
    };
		
}
