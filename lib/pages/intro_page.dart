// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kartf1/components/nav_bar.dart';
import 'package:kartf1/pages/Cart_page.dart';
import 'package:kartf1/pages/Circ_page.dart';
import 'package:kartf1/pages/Equip_page.dart';

import 'Book_page.dart';

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
    const BookPage(),

    const CircPage(),

    const EquipPage(),

    const CartPage(),
  ];

  final List<String> _names = [
    "Add Booking", "Circuits", "Equipment", "Cart"
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
      body: _pages[_selectedIndex],
    );
      // appBar: AppBar(
      //   title: Text(" ${_names[_selectedIndex]} "),
      //   titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
      //   backgroundColor: Colors.grey[300],
      //   automaticallyImplyLeading: false, // cambia lo del boton hacia atras (testear)
      //   scrolledUnderElevation: 0.0, // la barra superior deberia ser 100% transparente ahora
      //   elevation: 0,
        // leading: Builder(
        //   builder: (context) => IconButton(
        //       icon: const Padding(
        //         padding: EdgeInsets.only(left: 12.0),
        //         child: Icon(
        //           Icons.menu, 
        //           color: Colors.black,
        //           ),
        //       ),
        //         onPressed: () {
        //           Scaffold.of(context).openDrawer();
        //         },
        //       ),
        // ),
      
      // drawer: Drawer(
      //   backgroundColor: Colors.grey[900],
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Column(
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 25.0) ,
      //             child: Divider(
      //               color: Colors.grey[800],
      //             ),
      //           ),

      //           const Padding(
      //             padding: const EdgeInsets.only(left: 25.0),
      //             child: ListTile(
      //               leading: Icon(Icons.home, color: Colors.white,),
      //               title: Text(
      //                 'Home', 
      //                 style: TextStyle(color: Colors.white)
      //               ),
      //             ),
      //           ),

      //           // GestureDetector(
      //           //   onTap: () => Navigator.pushReplacement(
      //           //     context, MaterialPageRoute(
      //           //       builder: (context) {
      //           //         return const BookPage();
      //           //       },
      //           //     )
      //           //   )
                  
      //           // )
      //         ],
      //       ),
      //       const Padding(
      //         padding: EdgeInsets.only(left: 25.0, bottom: 25),
      //         child: ListTile(
      //           leading: Icon(
      //             Icons.logout, 
      //             color: Colors.white,
      //           ),
      //           title: Text(
      //             'Logout', 
      //             style: TextStyle(color: Colors.white)
      //           ),
      //         ),
      //       ),
      //     ],  
      //   ),
      // ),
      
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
    
  }
}