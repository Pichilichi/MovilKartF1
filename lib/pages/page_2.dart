// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Page2 extends StatelessWidget{
  const Page2({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // text 1 
          Padding(
            padding: EdgeInsets.only(
              left: 80, right: 80, bottom: 80, top: 160)
              ),
          //text
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              "Holiwi",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold
              )
            )
          ),
        ]
      )
    );
  }

}