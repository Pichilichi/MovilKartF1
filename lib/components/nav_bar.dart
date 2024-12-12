import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// NAVBAR CLASS
class MyNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyNavBar({super.key, required this.onTabChange});

  // Navbar build
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black, width:0.5))
      ),
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GNav(
        color: Colors.black,
        activeColor: Colors.indigo,
        tabBackgroundColor: Colors.white30,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 5,
        gap: 5,
        onTabChange: (value) => onTabChange!(value),
        tabs: const [
          GButton(
            icon: Icons.home_outlined 
          ),
          GButton(
            icon: Icons.other_houses_outlined
          ),
          GButton(
            icon: Icons.article_outlined,
          ),
          GButton(
            icon: Icons.shopping_bag_outlined,
          ),
          GButton(
            icon: Icons.shopping_cart_outlined,
          ),
        ],
      ),
    );
  }
}