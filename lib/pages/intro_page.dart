// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kartf1/components/nav_bar.dart';
import 'package:kartf1/pages/Cart_page.dart';
import 'package:kartf1/pages/Circ_page.dart';
import 'package:kartf1/pages/Equip_page.dart';

import 'Book_page.dart';

// INTRO CLASSES
class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  _IntroPageState createState() => _IntroPageState();
} 

// INTRO PAGE
class _IntroPageState extends State<IntroPage>{

  int _selectedIndex = 0;

  // Gets the index value of the navBar
  // Navigates to other pages based on the index and the list _pages
  void navBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [

    const BookPage(),

    const OthersBookPage(),

    const CircPage(),

    const EquipPage(),

    const CartPage(),
  ];

  // Intro build
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: MyNavBar(
        onTabChange: (index)=> navBottomBar(index),
      ),
      
      body: _pages[_selectedIndex],
    );
  }
}