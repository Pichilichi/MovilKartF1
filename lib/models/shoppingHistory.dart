import 'dart:convert';

List<ShoppingHistory> shoppingHistoryFromJson(String str) => List<ShoppingHistory>.from(json.decode(str).map((x) => ShoppingHistory.fromJson(x)));

String shoppingHistoryToJson(List<ShoppingHistory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShoppingHistory {
    int id;
    int user;
    String products;
    double indvPrice;
    double totalPrice;
    DateTime created;

    ShoppingHistory({
        required this.id,
        required this.user,
        required this.products,
        required this.indvPrice,
        required this.totalPrice,
        required this.created,
    });

    factory ShoppingHistory.fromJson(Map<String, dynamic> json) => ShoppingHistory(
        id: json["id"],
        user: json["user"],
        products: json["products"],
        indvPrice: json["indvPrice"],
        totalPrice: json["totalPrice"],
        created: DateTime.parse(json["created"]),

    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": user,
        "products": products,
        "indvPrice": indvPrice,
        "totalPrice": totalPrice,
        "created": created,
    };
}