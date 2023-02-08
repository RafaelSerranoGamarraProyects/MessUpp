// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());
//String encoded = sha256.convert(utf8.encode(input)).toString();

class User {
    User({
        required this.id,
        required this.email,
        required this.name,
        required this.surname,
        required this.password,
        required this.age,
        required this.dni,
        required this.profileImage,
        required this.telephoneNumber,
    });

    String id;
    String email;
    String name;
    String surname;
    String password;
    int age;
    String dni;
    String profileImage;
    int telephoneNumber;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        surname: json["surname"],
        password: json["password"],
        age: json["age"],
        dni: json["dni"],
        profileImage: json["profile_image"],
        telephoneNumber: json["telephone_number"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "name": name,
        "surname": surname,
        "password": password,
        "age": age,
        "dni": dni,
        "profile_image": profileImage,
        "telephone_number": telephoneNumber,
    };
}
