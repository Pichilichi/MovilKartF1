// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kartf1/models/event.dart';

import 'page_2.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
} 

class _IntroPageState extends State<IntroPage>{
  // List<Event> events = [];
  // var isLoaded = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          // padding top
          Padding(
            padding: EdgeInsets.only(
              left: 80, right: 80, bottom: 80, top: 160)
              ),
          //text
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              "Badabim badabum MISTERWORLWIDE ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold
              )
            )
          ),
          
          Text(
            "subtitulo wapo"
          ),

          // Padding(
          //   padding: EdgeInsets.all(24.0),
          //   child: ListView.builder(
          //         // itemCount: events.length,
          //         itemBuilder: (context, index) {
          //           return Container(
          //             child: Text('Hi'),
          //           );
          //         },
          //       ),
          // ),

          const Spacer(),

          //button 
          
          GestureDetector(
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const Page2();
              },
            )),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(24),
              child: Text(
                "Dale aqui",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          const Spacer(),
        ],
      )
    );
  }
}