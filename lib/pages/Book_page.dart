// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kartf1/models/bookings.dart';
import 'package:kartf1/models/messages.dart';
import 'package:kartf1/django/urls.dart';
import 'package:kartf1/models/users.dart';
import 'package:kartf1/pages/bookSelected_page.dart';
import 'package:kartf1/pages/intro_page.dart';


class BookPage extends StatefulWidget{
  const BookPage({Key? key}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();

  //añadir un "pullRefresh" para que podamos 
  //actualizar al arrastrar hacia abajo
}

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  _AddBookPageState createState() => _AddBookPageState();

}

class _BookPageState extends State<BookPage> {
  Client client = http.Client();
  List<Booking>? books = [];
  List<Messages>? msg = [];
  List<Users>? users = [];

  List<Messages> mensajes = [];
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

    users = await Urls().getUsers();
    if(users != null){
      setState(() {
        isLoaded = true;
      });
    }

    
  }

  getUsers() async{
    
  }


  getMsg() async {
    msg = await Urls().getMessages();
    if(msg != null){
      setState(() {
        isLoaded = true;
      });
    }
  
  }

  getMes(int index){
    var M;
    for(int i = 0; i < msg!.length; i++){
      if(msg!.isNotEmpty){
        M = msg!.where((x) => books![index].id == msg![i].booking).toList();
        //print(M[i].body);
      }else{
        print("AQUI");
      }
        
    }
    return M;
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
      appBar: AppBar(
        title: Text(" Booking "),
        actions: [
          IconButton(
          icon: Icon(Icons.add), 
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddBookPage()));
          },
         ),
        ],
        
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        backgroundColor: Colors.grey[300],
        automaticallyImplyLeading: false, // cambia lo del boton hacia atras (testear)
        scrolledUnderElevation: 0.0, // la barra superior deberia ser 100% transparente ahora
        elevation: 0,
      ),
      
      backgroundColor: Colors.grey[300],
      body: Visibility(
        visible: isLoaded,

        replacement: const Center(
          child: CircularProgressIndicator(),
        ),

        

        
        child: ListView.builder(
          itemCount: books?.length,
          

          
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(books![index].name),
              subtitle: Text(books![index].id.toString()),
              onTap: () {
                getMes(index);
                // print("Aquiii");
                // print(mensajes[index].body);
                // print(getMes(index));
                print(users);
                
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => bookSelectedPage(b: books![index], m: getMes(index), u: users),
                  ),
                );
              },
            );
            // return BookTile(
            //       B: books[index],
            //       onTap: () => Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => BookSelected(B: B)))
            //     );
            // return Container(
            //   padding: const EdgeInsets.all(16),
            //   child: Row(
            //     children: [
            //       Container(
            //         height: 50, 
            //         width: 50,
            //       ),
            //       SizedBox(width: 16,),
            //       Expanded(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               books![index].name, //BOOKINGS
            //               maxLines: 2,
            //               overflow: TextOverflow.ellipsis,
            //               style: TextStyle(
            //                 fontSize: 24,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //             Text(
            //               'Number of participants: ${books![index].racers.length}', //RACERS
            //               maxLines: 3,
            //               overflow: TextOverflow.ellipsis,
            //             ),
            //             Text(
            //               'Race Day : ${books![index].raceDay.day}/${books![index].raceDay.month}',//DATE
            //               maxLines: 3,
            //               overflow: TextOverflow.ellipsis,
            //             ),

                        
            //           ],
            //         ),
            //       ),
            //       Icon(
            //         Icons.cancel_rounded,
            //         size: 20
            //       ),
            //     ],
                
                
                
            //   ),
              
            //   // child: Text(events![index].name), //BOOKINGS
            // );
            
          },
          
        ),

        // child: ElevatedButton(onPressed: () {  }, child: null,),
       
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
  
class _AddBookPageState extends State<AddBookPage>{

  

  void addBooking(String bookName, raceDay, user, circuit) async{

    try{

      print("dentro del response");
      Response response = await post(
        Uri.parse('https://pacou.pythonanywhere.com/bookings/'),
        body: {
          'name': bookName,
          'raceDay': raceDay,
          'user': user,
          'circuit': circuit,
        }
      );

      if(response.statusCode == 201){
        var data = jsonDecode(response.body.toString());
        print('data added');
        print(data);
        Navigator.push(context, MaterialPageRoute(builder: (context) => IntroPage()));
        // IntroPage(), prueba a ver si sale la barra de abajo asi
      }else{
        print('failed');
        showDialog(
          context: context, 
          builder: (context) => AlertDialog(
            title: Text('Something went wrong...'),
            content: Text('Check the data'),
          ),
        );
      }
    }catch(e){
      print(e.toString());
    }
  }

  TextEditingController nameBook = TextEditingController();
  TextEditingController raceDayBook = TextEditingController();
  TextEditingController userBook = TextEditingController();
  TextEditingController circuitBook = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Add a booking "),
        actions: [
          IconButton(
          icon: Icon(Icons.arrow_back), 
          onPressed: (){
            Navigator.pop(context, MaterialPageRoute(builder: (context) => IntroPage()));
          },
         ),
        ],
        
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        backgroundColor: Colors.grey[300],
        automaticallyImplyLeading: false, // cambia lo del boton hacia atras (testear)
        scrolledUnderElevation: 0.0, // la barra superior deberia ser 100% transparente ahora
        elevation: 0,
      ),
      
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),

            TextField(
              controller: nameBook,
              decoration: InputDecoration(
                hintText: 'Booking name',
                border: OutlineInputBorder(

                ),
              ),
            ),

            const SizedBox(height: 20,),


            TextField(
              controller: raceDayBook,
              decoration: InputDecoration(
                hintText: 'YYYY-MM-DD',
                border: OutlineInputBorder(

                ),
              ),
            ),

             TextField(
              controller: userBook,
              decoration: InputDecoration(
                hintText: 'user',
                border: OutlineInputBorder(

                ),
              ),
            ),

            TextField(
              controller: circuitBook,
              decoration: InputDecoration(
                hintText: 'Circuit',
                border: OutlineInputBorder(

                ),
              ),
            ),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                addBooking(nameBook.text.toString(), raceDayBook.text.toString(), 
                userBook.text.toString(), circuitBook.text.toString());
                // Navigator.push(context, MaterialPageRoute(builder: (context) => IntroPage())); 
              },
              child: Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'Add Booking', 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
//             ElevatedButton(
//               child: const Text('Registro'),
//               onPressed: () {
//                 Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const RegisterPage()),
//               );
// }
//             ),
          ],
        ),
      ),
    );
  }
}

