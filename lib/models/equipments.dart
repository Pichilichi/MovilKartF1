import 'dart:convert';

List<Equipments> equipmentsFromJson(String str) => List<Equipments>.from(json.decode(str).map((x) => Equipments.fromJson(x)));

String equipmentsToJson(List<Equipments> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Equipments {
    int id;
    String name;
    String equipmentCategory;
    int price;
    DateTime updated;
    DateTime created;

    Equipments ({
        required this.id,
        required this.name,
        required this.equipmentCategory,
        required this.price,
        required this.updated,
        required this.created,
    });

    factory Equipments.fromJson(Map<String, dynamic> json) => Equipments(
        id: json["id"],
        name: json["name"],
        equipmentCategory: json["equipment_category"],
        price: json["price"].toInt(), // FROM FLOAT/DOUBLE TO INT
        updated: DateTime.parse(json["updated"]),
        created: DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "equipment_category": equipmentCategory,
        "price": price,
        "updated": updated.toIso8601String(),
        "created": created.toIso8601String(),
    };
}
