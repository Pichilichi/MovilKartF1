import 'dart:convert';

// TRANSFORMS EQUIPMENTS FROM JSON INTO A LIST
List<Equipments> equipmentsFromJson(String str) => List<Equipments>.from(json.decode(str).map((x) => Equipments.fromJson(x)));

// TRANSFORMS EQUIPMENTS FROM A LIST INTO JSON
String equipmentsToJson(List<Equipments> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// EQUIPMENTS CLASS
class Equipments {
    int id;
    String name;
    String img;
    String equipmentCategory;
    int price;
    int stock;
    DateTime updated;
    DateTime created;

    Equipments ({
        required this.id,
        required this.name,
        required this.img,
        required this.equipmentCategory,
        required this.price,
        required this.stock,
        required this.updated,
        required this.created,
    });

    factory Equipments.fromJson(Map<String, dynamic> json) => Equipments(
        id: json["id"],
        name: json["name"],
        img: json["img"],
        equipmentCategory: json["equipment_category"],
        price: json["price"].toInt(), // FROM FLOAT/DOUBLE TO INT
        stock : json["stock"],
        updated: DateTime.parse(json["updated"]),
        created: DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "img": img,
        "equipment_category": equipmentCategory,
        "price": price,
        "stock": stock,
        "updated": updated.toIso8601String(),
        "created": created.toIso8601String(),
    };
}
