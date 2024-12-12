import 'dart:convert';

// TRANSFORMS CATEGORIES FROM JSON INTO A LIST
List<Categories> categoriesFromJson(String str) => List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

// TRANSFORMS CATEGORIES FROM A LIST INTO JSON
String categoriesToJson(List<Categories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// CATEGORIES CLASS
class Categories {
    int id;
    String name;

    Categories({
        required this.id,
        required this.name,
    });

    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
