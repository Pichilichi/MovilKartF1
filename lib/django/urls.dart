import 'package:kartf1/models/bookings.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'dart:async';

import '../models/categories.dart';
import '../models/circuits.dart';
import '../models/equipments.dart';
import '../models/karts.dart';

// CLASS WITH ALL THE CALLS TO THE ENDPOINTS
class Urls{

  //BOOKINGS
  Future<List<Booking>?> getBookings() async {  
    var client = http.Client();

    var uri = Uri.parse('https://pacou.pythonanywhere.com/bookings/');
    var response = await client.get(uri);
    if(response.statusCode == 200){
      var json = response.body;
      return bookingFromJson(json);
    }
  }

  //CIRCUITS
  Future<List<Circuits>?> getCircuits() async {
    var client = http.Client();

    var uri = Uri.parse('https://pacou.pythonanywhere.com/circuits/');
    var response = await client.get(uri);
    if(response.statusCode == 200){
      var json = response.body;
      return circuitsFromJson(json);
    }
  }

  //CATEGORIES
  Future<List<Categories>?> getCategories() async {
    var client = http.Client();

    var uri = Uri.parse('https://pacou.pythonanywhere.com/categories/');
    var response = await client.get(uri);
    if(response.statusCode == 200){
      var json = response.body;
      return categoriesFromJson(json);
    }
  }

  //EQUIPMENTS
  Future<List<Equipments>?> getEquipments() async {
    var client = http.Client();

    var uri = Uri.parse('https://pacou.pythonanywhere.com/equipments/');
    var response = await client.get(uri);
    if(response.statusCode == 200){
      var json = response.body;
      return equipmentsFromJson(json);
    }
  }

  //KARTS
  Future<List<Karts>?> getKarts() async {
    var client = http.Client();

    var uri = Uri.parse('https://pacou.pythonanywhere.com/karts/');
    var response = await client.get(uri);
    if(response.statusCode == 200){
      var json = response.body;
      return kartsFromJson(json);
    }
  }
}