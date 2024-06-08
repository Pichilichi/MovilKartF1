// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'page_2.dart';

class IntroPage extends StatelessWidget{
  const IntroPage({super.key});

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