import 'package:flutter/material.dart';
import 'package:kartf1/models/equipments.dart';

// CART CLASS
class Cart extends ChangeNotifier {

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

  (String, double) addPurchase() {
    String products = "";
    double finalPrice = 0;
    for(int i = 0; i < userCart.length; i++){
      products = "$products${userCart[i].name} ---- ${userCart[i].price}E \n";
      finalPrice = finalPrice + userCart[i].price;
    }
    return (products, finalPrice);
  }
  
}