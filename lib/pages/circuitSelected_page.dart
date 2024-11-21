import 'package:flutter/material.dart';
import 'package:kartf1/models/circuits.dart';

class circuitSelectedPage extends StatelessWidget {
  // In the constructor, require a Todo.
  const circuitSelectedPage({super.key, required this.c});

  // Declare a field that holds the Todo.
  final Circuits c;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(c.name),
      ),
      body: Column(
        children: [
          Image.network("https://pacou.pythonanywhere.com${c.img}"),

          Text(c.name),

          Text(c.body)
        ],  
      ),
    );
  }
}