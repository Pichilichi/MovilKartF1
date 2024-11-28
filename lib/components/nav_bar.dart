import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyNavBar({super.key, required this.onTabChange});


  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black, width:0.5))
      ),
      padding: EdgeInsets.symmetric(vertical: 5),
      child: GNav(
        color: Colors.black,
        activeColor: Colors.indigo,
        // tabActiveBorder: Border.all(color: Colors.blueAccent),
        tabBackgroundColor: Colors.white30,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 5,
        gap: 5,

        onTabChange: (value) => onTabChange!(value),
        tabs: [
          GButton(
            icon: Icons.home_outlined 
          ),
          GButton(
            icon: Icons.article_outlined,
//            text: 'Circuits',
          ),
          GButton(
            icon: Icons.shopping_bag_outlined,
 //           text: 'Shop',
          ),
          GButton(
            icon: Icons.shopping_cart_outlined,
  //          text: 'Cart',
          ),
        ],
      ),
    );
  }
}