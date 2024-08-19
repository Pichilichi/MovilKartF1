
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kartf1/models/circuits.dart';
import 'package:kartf1/django/urls.dart';


class CircPage extends StatefulWidget{
  const CircPage({Key? key}) : super(key: key);

  @override
  _CircPageState createState() => _CircPageState();
}

class PruebaPage extends StatefulWidget {
  const PruebaPage({super.key});

  @override
  _PruebaPageState createState() => _PruebaPageState();

}

 

class _CircPageState extends State<CircPage> {

  Client client = http.Client();
  List<Circuits>? circuits = [];
  var isLoaded = false;

  @override
  void initState(){
    // _retrieveEvents();
    super.initState();

    getData();
  }

  getData() async {
    circuits = await Urls().getCircuits();
    if(circuits != null){
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Visibility(
        visible: isLoaded, 
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PruebaPage()));
          },
          child: Hero(
            tag: "hero",
            child: Image.network("https://picsum.photos/250?image=9"),
          ),
        ),
          
      ),
    );
  }


  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.grey[300],
  //     body: Visibility(
  //       visible: isLoaded,
  //       child: ListView.builder(
  //         itemCount: circuits?.length,
  //         itemBuilder: (context, index) {
  //           return Container(
  //             padding: const EdgeInsets.all(16),
  //             child: Row(
  //               children: [
  //                 Container(
  //                   height: 50, 
  //                   width: 50,
  //                 ),
  //                 SizedBox(width: 16,),
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         circuits![index].name, //CIRCUITS
  //                         maxLines: 2,
  //                         overflow: TextOverflow.ellipsis,
  //                         style: TextStyle(
  //                           fontSize: 24,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                       Text(
  //                         circuits![index].body, //DESCRIPTION
  //                         maxLines: 20,
  //                         overflow: TextOverflow.ellipsis,
  //                       ),
  //                       Text(
  //                         'Track length : '  +
  //                         circuits![index].km.toString() + ' km',
  //                         //DATE
  //                         maxLines: 1,
  //                         overflow: TextOverflow.ellipsis,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             // child: Text(events![index].name), //BOOKINGS
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}

class _PruebaPageState extends State<PruebaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Hero(
          tag: "hero",
          child: Image.network("https://picsum.photos/250?image=9"),
        ),
      ),
    );
  }
 }