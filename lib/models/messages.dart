
import 'dart:convert';

List<Messages> messagesFromJson(String str) => List<Messages>.from(json.decode(str).map((x) => Messages.fromJson(x)));

String messagesToJson(List<Messages> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Messages {
    int id;
    String body;
    DateTime updated;
    DateTime created;
    int user;
    int booking;

    Messages({
        required this.id,
        required this.body,
        required this.updated,
        required this.created,
        required this.user,
        required this.booking,
    });

    factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        id: json["id"],
        body: json["body"],
        updated: DateTime.parse(json["updated"]),
        created: DateTime.parse(json["created"]),
        user: json["user"],
        booking: json["booking"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "updated": updated.toIso8601String(),
        "created": created.toIso8601String(),
        "user": user,
        "booking": booking,
    };
}
