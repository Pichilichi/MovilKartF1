import 'dart:convert';

List<Karts> kartsFromJson(String str) => List<Karts>.from(json.decode(str).map((x) => Karts.fromJson(x)));

String kartsToJson(List<Karts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Karts {
    int id;
    String name;
    int cc;
    String color;
    DateTime updated;
    DateTime created;
    int user;

    Karts({
        required this.id,
        required this.name,
        required this.cc,
        required this.color,
        required this.updated,
        required this.created,
        required this.user,
    });

    factory Karts.fromJson(Map<String, dynamic> json) => Karts(
        id: json["id"],
        name: json["name"],
        cc: json["cc"],
        color: json["color"],
        updated: DateTime.parse(json["updated"]),
        created: DateTime.parse(json["created"]),
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cc": cc,
        "color": color,
        "updated": updated.toIso8601String(),
        "created": created.toIso8601String(),
        "user": user,
    };
}
