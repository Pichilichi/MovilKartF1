import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyNavBar({super.key, required this.onTabChange});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: GNav(
        color: Colors.black,
        activeColor: Colors.black54,
        tabActiveBorder: Border.all(color: Colors.blueAccent),
        tabBackgroundColor: Colors.blue.shade100,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 5,
        gap: 4,
        onTabChange: (value) => onTabChange!(value),
        tabs: const [
          GButton(
            icon: Icons.home,
          ),
          GButton(
            icon: Icons.art_track,
//            text: 'Circuits',
          ),
          GButton(
            icon: Icons.shopping_bag_rounded,
 //           text: 'Shop',
          ),
          GButton(
            icon: Icons.shopping_cart,
  //          text: 'Cart',
          ),
        ],
      ),
    );
  }
}