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

  (String, double) addPurchase() {
    String products = "";
    double finalPrice = 0;
    for(int i = 0; i < userCart.length; i++){
      // print(userCart[i].name + " " + userCart[i].price.toString());
      products = "$products${userCart[i].name} ${userCart[i].price} ";
      finalPrice = finalPrice + userCart[i].price;
      //"$finalPrice${userCart[i].price}" as double;
    }
    print(products);
    print(finalPrice);

    return (products, finalPrice);
    
  }
  
}