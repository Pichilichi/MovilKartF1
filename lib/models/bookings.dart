import 'dart:convert';

// TRANSFORMS BOOKINGS FROM JSON INTO A LIST
List<Booking> bookingFromJson(String str) => List<Booking>.from(json.decode(str).map((x) => Booking.fromJson(x)));

// TRANSFORMS BOOKINGS FROM A LIST INTO JSON
String bookingToJson(List<Booking> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// BOOKING CLASS
class Booking {
    int id;
    String name;
    DateTime raceDay;
    DateTime updated;
    DateTime created;
    int user;
    int circuit;
    List<int> racers;

    Booking({
        required this.id,
        required this.name,
        required this.raceDay,
        required this.updated,
        required this.created,
        required this.user,
        required this.circuit,
        required this.racers,
    });

    factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        name: json["name"],
        raceDay: DateTime.parse(json["raceDay"]),
        updated: DateTime.parse(json["updated"]),
        created: DateTime.parse(json["created"]),
        user: json["user"],
        circuit: json["circuit"],
        racers: List<int>.from(json["racers"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "raceDay": "${raceDay.year.toString().padLeft(4, '0')}-${raceDay.month.toString().padLeft(2, '0')}-${raceDay.day.toString().padLeft(2, '0')}",
        "updated": updated.toIso8601String(),
        "created": created.toIso8601String(),
        "user": user,
        "circuit": circuit,
        "racers": List<dynamic>.from(racers.map((x) => x)),
    };
}
