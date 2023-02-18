// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);



import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());
//String encoded = sha256.convert(utf8.encode(input)).toString();

class User {
    User({
        required this.email,
        required this.password,
        this.name,
        this.profileImage,
    });

    String email;
    String? name;
    String password;
    String? profileImage;


    factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        name: json["name"],
        password: json["password"],
        profileImage: json["profile_image"],

    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "password": password,
        "profile_image": profileImage,
    };
}
