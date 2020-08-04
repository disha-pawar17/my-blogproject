
//MODEL CLASS FOR USER DATA
import 'dart:convert';

class UserModel {

  String id;
  String username;
  String email;
  String password;
  double contact;
  DateTime createdAt;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.password,
    this.contact,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
    contact: double.parse(json["contact"]),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "password": password,
    "contact":contact,
    "createdAt": createdAt.toIso8601String(),
  };
}

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());
