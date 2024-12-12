import 'package:flutter/material.dart';
import 'package:kartf1/models/cart.dart';
import 'package:kartf1/pages/login_page.dart';
import 'package:provider/provider.dart';

// Main
void main() {
  runApp(const MyApp());
}

// MAIN PAGE
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //Main build. Creates the cart and the login page
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      builder: (context, child) => const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      ),
    );
  }
}