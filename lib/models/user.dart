import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());
//String encoded = sha256.convert(utf8.encode(input)).toString();

class User {
    User({
        this.id,
        required this.email,
        required this.password,
        this.userName,
        this.image,
    });

    String? id;
    String email;
    String? userName;
    String password;
    String? image;


    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        userName: json["userName"],
        password: json["password"],
        image: json["image"],

    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "userName": userName,
        "password": password,
        "image": image,
    };

    factory User.fromFirestore(
        DocumentSnapshot<Map<String, dynamic>> snapshot,
        SnapshotOptions? options,
     ) {
        final data = snapshot.data();
    return User(
        id: snapshot.id,
        email: data?['email'],
        userName: data?["userName"],
        password: data?['password'],
        image: data?['image'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
        "email": email,
        "userName": userName,
        "password": password,
        "image": image,

    };
  }
}
