import 'package:flutter/material.dart';
import 'package:kartf1/models/bookings.dart';
import 'package:kartf1/pages/Book_page.dart';
import 'package:kartf1/pages/intro_page.dart';

class bookSelectedPage extends StatelessWidget {
  // In the constructor, require a Todo.
  const bookSelectedPage({super.key, required this.b});

  // Declare a field that holds the Todo.
  final Booking b;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(b.name),
        actions: [
          IconButton(onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Are you sure you want to delete the booking?"),
                actions: [
                  
                  TextButton(
                    onPressed: () => Navigator.pop(context), 
                    child: const Text("Cancel")
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => IntroPage()));
                      // el borrarlo de la api
                    },
                    child: Text(b.id.toString())
                  ), //id del booking para borrarlo
                ],
              )
            );
          }, icon: const Icon (Icons.delete))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text('Number of participants: ${b.racers.length}')
      ),
    );
  }
}