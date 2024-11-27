import 'dart:convert';

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
    int id;
    String username;

    Users({
        required this.id,
        required this.username
    });

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        username: json["username"],

    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
    };
}