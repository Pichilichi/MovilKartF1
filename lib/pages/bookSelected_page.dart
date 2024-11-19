import 'package:flutter/material.dart';
import 'package:kartf1/models/bookings.dart';

class BookselectedPage extends StatelessWidget {
  // In the constructor, require a Todo.
  const BookselectedPage({super.key, required this.b});

  // Declare a field that holds the Todo.
  final Booking b;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(b.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text('Number of participants: ${b.racers.length}')
      ),
    );
  }
}