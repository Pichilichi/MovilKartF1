import 'dart:convert';

// TRANSFORMS USERS FROM JSON INTO A LIST
List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

// TRANSFORMS USERS FROM A LIST INTO JSON
String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// USER CLASS
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