// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kartf1/models/bookings.dart';
import 'package:kartf1/models/messages.dart';
import 'package:kartf1/django/urls.dart';


class Page2 extends StatefulWidget{
  const Page2({Key? key}) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  Client client = http.Client();
  List<Booking>? books = [];
  List<Messages>? msg = [];
  var isLoaded = false;

  @override
  void initState(){
    // _retrieveEvents();
    super.initState();

    getData();
    getMsg();
  }

  getData() async {
    books = await Urls().getBookings();
    if(books != null){
      setState(() {
        isLoaded = true;
      });
    }
  }

  getMsg() async {
    msg = await Urls().getMessages();
    if(msg != null){
      setState(() {
        isLoaded = true;
      });
    }
  }

  // _retrieveEvents() async {
  //   events = [];

  //   List response = json.decode((await client.get(getEvents as Uri)).body);
  //   response.forEach((element) {
  //     events.add(Event.fromMap(element));
  //   });
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: books?.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    height: 50, 
                    width: 50,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          books![index].name, //BOOKINGS
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Number of participants: ' +
                          books![index].racers.length.toString(), //RACERS
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Race Day : ' +
                          books![index].raceDay.day.toString() + '/' + books![index].raceDay.month.toString(),//DATE
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // child: Text(events![index].name), //BOOKINGS
            );
          },
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      // body: SafeArea(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       const SizedBox(height: 48),

      //       //Text1
      //       const Padding(
      //         padding: EdgeInsets.symmetric(horizontal: 24.0),
      //         child: Text("Holiwi"),
      //         ),

      //       const SizedBox(height: 4),

      //         //Text2
      //         Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 24.0),
      //           child: Text("Que tal?",
      //             style: TextStyle(
      //               fontSize: 40,
      //               fontWeight: FontWeight.bold
      //             ),
      //           ),
      //         ),

      //         const SizedBox(height: 24),

      //         //Divider
      //         const Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 24.0),
      //           child: Divider(),
      //         ),

      //         const SizedBox(height: 24),

      //         //Text below divider
      //         Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 24.0),
      //           child: ListView.builder(
      //             itemCount: events?.length,
      //             itemBuilder: (context, index) {
      //               return Container(
      //                 child: Text('Hi'),
      //               );
      //             },
      //           ),
      //           // child: Text(
      //           //   "Cositas aqui",
      //           //   style: TextStyle(fontSize: 16)
      //           // ),
      //         ),

              
      //     ],
      //   ),
      // )
    );
  }
}
  