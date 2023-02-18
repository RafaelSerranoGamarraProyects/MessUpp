import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

Group groupFromJson(String str) => Group.fromJson(json.decode(str));

String groupToJson(Group data) => json.encode(data.toJson());

class Group {

    Group({
        this.id,
        required this.creationDate,
        required this.image,
        required this.participants,
        required this.transactions
    });

    String? id;
    DateTime creationDate;
    List<Map<String,dynamic>> participants;
    List<Map<String,dynamic>> transactions;
    String image;

    factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        creationDate: DateTime.parse(json["creationDate"]),
        participants: json["participants"],
        transactions: json["transactions"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "creationDate": creationDate.toIso8601String(),
        "participants": participants,
        "transactions": transactions,
        "image": image,
    };


    factory Group.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Group(
      id: snapshot.id,
      creationDate: DateTime.parse(data?['creationDate']),
      participants: data?['participants'],
      transactions: data?['transactions'],
      image: data?['image'],

    );
  }

  Map<String, dynamic> toFirestore() {
    return {
        "creationDate": creationDate,
        "participants": participants,
        "transactions": transactions,
        "image": image,
    };
  }
  
}
