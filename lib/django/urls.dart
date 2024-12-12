import 'package:kartf1/models/bookings.dart';
import 'package:http/http.dart' as http;
import 'package:kartf1/models/shoppingHistory.dart';
import 'dart:async';
import '../models/categories.dart';
import '../models/circuits.dart';
import '../models/equipments.dart';
import '../models/messages.dart';
import '../models/users.dart';

// CLASS WITH ALL THE CALLS TO THE ENDPOINTS
class Urls{

  static Users? currentUser;

  // BOOKINGS
  Future<List<Booking>?> getBookings() async {  
    var client = http.Client();

    var uri = Uri.parse('https://pacou.pythonanywhere.com/bookings/');
    var response = await client.get(uri);
    if(response.statusCode == 200){
      var json = response.body;
      return bookingFromJson(json);
    }
  }

  // CIRCUITS
  Future<List<Circuits>?> getCircuits() async {
    var client = http.Client();

    var uri = Uri.parse('https://pacou.pythonanywhere.com/circuits/');
    var response = await client.get(uri);
    if(response.statusCode == 200){
      var json = response.body;
      return circuitsFromJson(json);
    }
  }

  // CATEGORIES
  Future<List<Categories>?> getCategories() async {
    var client = http.Client();

    var uri = Uri.parse('https://pacou.pythonanywhere.com/categories/');
    var response = await client.get(uri);
    if(response.statusCode == 200){
      var json = response.body;
      return categoriesFromJson(json);
    }
  }

  // EQUIPMENTS
  Future<List<Equipments>?> getEquipments() async {
    var client = http.Client();

    var uri = Uri.parse('https://pacou.pythonanywhere.com/equipments/');
    var response = await client.get(uri);
    if(response.statusCode == 200){
      var json = response.body;
      return equipmentsFromJson(json);
    }
  }

  // MESSAGES
  Future<List<Messages>?> getMessages() async {
    var client = http.Client();

    var uri = Uri.parse('https://pacou.pythonanywhere.com/messages/');
    var response = await client.get(uri);
    if(response.statusCode == 200){
      var json = response.body;
      return messagesFromJson(json);
    }
  }

  // USERS
  Future<List<Users>?> getUsers() async {
    var client = http.Client();

    var uri = Uri.parse('https://pacou.pythonanywhere.com/users/');
    var response = await client.get(uri);
    if(response.statusCode == 200){
      var json = response.body;
      return usersFromJson(json);
    }
  }

  // PURCHASES
  Future<List<ShoppingHistory>?> getPurchases() async {
    var client = http.Client();

    var uri = Uri.parse('https://pacou.pythonanywhere.com/shoppingHistory/');
    var response = await client.get(uri);
    if(response.statusCode == 200){
      var json = response.body;
      return shoppingHistoryFromJson(json);
    }
  }

  // SETS THE CURRENT USER
  setUser(String user, int id) {
    currentUser = Users(id : id, username : user);
  }

  // GETS THE CURRENT USER
  static getUser()  {
    return currentUser;
  }
}


