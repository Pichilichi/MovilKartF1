import 'package:flutter/material.dart';
import 'package:kartf1/models/equipments.dart';
// import 'package:kartf1/models/photo.dart';

class Cart extends ChangeNotifier {
  // List<Equipments> eqShop = [];

  // List<Photo> ph = [
  //   Photo(
  //     imagePath: 'lib/images/casco.jpg'
  //   )
  // ];

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

  void clearCart(){
    userCart.clear();
    notifyListeners();
  }
}