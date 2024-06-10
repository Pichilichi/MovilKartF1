import 'package:kartf1/models/event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

// const baseUrl = "http://127.0.0.1:8000/";

// var baseUrl = Uri.parse("http://127.0.0.1:8000/");

// Future<List<Event>> getEvents() async {
//     final response = await http.get('$baseUrl/events' as Uri);

//     if (response.statusCode == 200) {
//       final List result = json.decode(response.body);
//       return result.map((e) => Event.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

class Urls{

  Future<List<Booking>?> getEvents() async {
    var client = http.Client();

    var uri = Uri.parse('https://pacou.pythonanywhere.com/bookings/');
    var response = await client.get(uri);
    if(response.statusCode == 200){
      var json = response.body;
      return bookingFromJson(json);
    }
  }
}