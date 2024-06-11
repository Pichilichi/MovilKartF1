// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kartf1/components/nav_bar.dart';
import 'package:kartf1/pages/page_3.dart';

import 'page_2.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
} 

class _IntroPageState extends State<IntroPage>{
  int _selectedIndex = 0;

  void navBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    //BOOKINGS
    const Page2(),

    const Page3(),
  ];
  // List<Event> events = [];
  // var isLoaded = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: MyNavBar(
        onTabChange: (index)=> navBottomBar(index),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu, 
                color: Colors.black,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
      ),
      body: _pages[_selectedIndex],
      // body: Column(
      //   children: [
      //     // padding top
      //     Padding(
      //       padding: EdgeInsets.only(
      //         left: 80, right: 80, bottom: 80, top: 160)
      //         ),
      //     //text
      //     Padding(
      //       padding: EdgeInsets.all(24.0),
      //       child: Text(
      //         "Badabim badabum MISTERWORLWIDE ",
      //         textAlign: TextAlign.center,
      //         style: TextStyle(
      //           fontSize: 40,
      //           fontWeight: FontWeight.bold
      //         )
      //       )
      //     ),
          
      //     Text(
      //       "subtitulo wapo"
      //     ),

      //     // Padding(
      //     //   padding: EdgeInsets.all(24.0),
      //     //   child: ListView.builder(
      //     //         // itemCount: events.length,
      //     //         itemBuilder: (context, index) {
      //     //           return Container(
      //     //             child: Text('Hi'),
      //     //           );
      //     //         },
      //     //       ),
      //     // ),

      //     const Spacer(),

      //     //button 
          
      //     GestureDetector(
      //       onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(
      //         builder: (context) {
      //           return const Page2();
      //         },
      //       )),
      //       child: Container(
      //         decoration: BoxDecoration(
      //           color: Colors.indigoAccent,
      //           borderRadius: BorderRadius.circular(12),
      //         ),
      //         padding: EdgeInsets.all(24),
      //         child: Text(
      //           "Dale aqui",
      //           style: TextStyle(color: Colors.white),
      //         ),
      //       ),
      //     ),

      //     const Spacer(),
      //   ],
      // )
    );
  }
}