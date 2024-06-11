import 'package:flutter/material.dart';
import 'package:kartf1/models/equipments.dart';

class Cart extends ChangeNotifier {
  // List<Equipments> eqShop = [];

  List<Equipments> userCart = [];

  List<Equipments> getUserCart() {
    return userCart;
  }

  void addItemToCart(Equipments equipment){
    userCart.add(equipment);
    notifyListeners();
  }

  void removeItemFromCart(Equipments equipment){
    userCart.remove(equipment);
    notifyListeners();
  }
}