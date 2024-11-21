import 'dart:convert';

List<Circuits> circuitsFromJson(String str) => List<Circuits>.from(json.decode(str).map((x) => Circuits.fromJson(x)));

String circuitsToJson(List<Circuits> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Circuits {
    int id;
    String name;
    DateTime year;
    String km;
    String body;
    String img;
    DateTime updated;
    DateTime created;
    int category;

    Circuits({
        required this.id,
        required this.name,
        required this.year,
        required this.km,
        required this.body,
        required this.img,
        required this.updated,
        required this.created,
        required this.category,
    });

    factory Circuits.fromJson(Map<String, dynamic> json) => Circuits(
        id: json["id"],
        name: json["name"],
        year: DateTime.parse(json["year"]),
        km: json["km"],
        body: json["body"],
        img: json["img"],
        updated: DateTime.parse(json["updated"]),
        created: DateTime.parse(json["created"]),
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "year": "${year.year.toString().padLeft(4, '0')}-${year.month.toString().padLeft(2, '0')}-${year.day.toString().padLeft(2, '0')}",
        "km": km,
        "body": body,
        "img": img,
        "updated": updated.toIso8601String(),
        "created": created.toIso8601String(),
        "category": category,
    };
}