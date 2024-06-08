// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Page2 extends StatelessWidget{
  const Page2({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),

            //Text1
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text("Holiwi"),
              ),

            const SizedBox(height: 4),

              //Text2
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text("Que tal?",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),

              const SizedBox(height: 24),

              //Divider
              const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Divider(),
              ),

              const SizedBox(height: 24),

              //Text below divider
              const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Cositas aqui",
                  style: TextStyle(fontSize: 16)
                ),
              ),

              
          ],
        ),
      )
    );
  }

}