import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kartf1/models/bookings.dart';
import 'package:kartf1/models/messages.dart';
import 'package:kartf1/models/users.dart';
import 'package:kartf1/pages/Book_page.dart';
import 'package:kartf1/pages/intro_page.dart';

class bookSelectedPage extends StatelessWidget {
  const bookSelectedPage({super.key, required this.b, required this.m, 
  required this.u, required this.currentUser});

  final Booking b;
  final m;
  final List <Users>? u;
  final Users currentUser;
  // final List <Users>? currentUser;

  allMesagges(){
    List<Messages> M = [];
    for(int i = 0; i < m.length; i++){
      if(b.id == m[i].booking){
        M.add(m[i]);
      }
    }
    return M;
  }


  getUser(List <Users>? user, int id){
    for(int i = 0; i < user!.length; i++){
      if(id == user[i].id){
        return user[i].username;
      }
    }
  }

  Future<void> deleteBooking() async {
    try{
      Response response = await delete(
        Uri.parse("https://pacou.pythonanywhere.com/bookings/${b.id}")
      );

      if(response.statusCode == 204){
        //print("Borrado");
      }
      
    }catch(e){
      print(e);
    }
  }

  Future<void> deleteMsg(int m) async {

    try{
      Response response = await delete(
        Uri.parse("https://pacou.pythonanywhere.com/messages/${m}")
      );

      if(response.statusCode == 204){
        //print("Borrado");
      }
      
    }catch(e){
      print(e);
    }
  }

  

  @override
  Widget build(BuildContext context) {
    List<Messages> M = allMesagges();
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(b.name + " " + b.raceDay.day.toString() + "/" + b.raceDay.month.toString()),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        actions: [
          IconButton( onPressed: currentUser.id == b.user 
          ? () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Are you sure you want to delete the booking?"),
                actions: [

                  TextButton(
                    onPressed: () => Navigator.pop(context), 
                    child: const Text("Cancel")
                  ),

                  TextButton(
                    onPressed: () async {
                      deleteBooking();
                      final sb = SnackBar(content: 
                      Text("Booking deleted!"),
                      duration: const Duration(milliseconds: 2000),);
                      ScaffoldMessenger.of(context).showSnackBar(sb);
                      await Navigator.push(context, MaterialPageRoute(builder: (context) => const IntroPage()));
                      
                      // el borrarlo de la api
                    },
                    child: Text("Delete")
                  ), //id del booking para borrarlo
                ],
              )
            );
          } : () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text ("You cant delete this"),
                actions: [

                  TextButton(
                    onPressed: () => Navigator.pop(context), 
                    child: const Text("Ups! Sorry")
                  ),
                ],
              )
            );
          },

          
          
          // } currentUser?[0].id == b.user : () {
          //   showDialog(
          //     context: context,
          //     builder: (context) => AlertDialog(
          //       title: const Text ("You cant delete this"),
          //       actions: [

          //         TextButton(
          //           onPressed: () => Navigator.pop(context), 
          //           child: const Text("Cancel")
          //         ),
          //       ],
          //     )
          //   );
          // },    
          icon: const Icon (Icons.delete)),

          IconButton(
          icon: Icon(Icons.add), 
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddMsgPage(b : b, currentUser: currentUser,)));
          },
         ),
        ],
      ),
      
      backgroundColor: Colors.white,
      body:  M.isNotEmpty 
      ? Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: M.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(M[index].body),
                  //subtitle: Text(M[index].user.toString())
                  subtitle: Text(" ${getUser(u, M[index].user)} "),
                  trailing: currentUser.id == M[index].user 
                  ? IconButton( 
                      icon: const Icon(Icons.clear_sharp),
                      onPressed: () async {
                        deleteMsg(M[index].id);
                        await Navigator.push(context, MaterialPageRoute(builder: (context) => const IntroPage()));
                      },
                    ) : const Text(" "),
                );
              },
            ),
          ),
        ],
      ) : const Center(child: Text("Nothing here, man")
      ),
      
    );
  }
}

class AddMsgPage extends StatefulWidget {
  const AddMsgPage({super.key, required this.b, required this.currentUser});

  final Booking b;
  final Users currentUser;

  @override
  _AddMsgPageState createState() => _AddMsgPageState();

}

class _AddMsgPageState extends State<AddMsgPage>{


void addMsg(String bodyMsg, bookingId, currentUserId) async{

    try{

      print("dentro del response");
      Response response = await post(
        Uri.parse('https://pacou.pythonanywhere.com/messages/'),
        body: {
          'body': bodyMsg,
          'user': currentUserId.toString(),
          'booking': bookingId.toString(),
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

  TextEditingController bodyMsg = TextEditingController();
  // final _sbCreated = SnackBar(content: 
  //   Text("Booking created!"),
  //   duration: const Duration(milliseconds: 2000),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Add a message! "),
        actions: [
          IconButton(
          icon: Icon(Icons.arrow_back), 
          onPressed: (){
            Navigator.pop(context, MaterialPageRoute(builder: (context) => IntroPage()));
          },
         ),
        ],
        
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, // cambia lo del boton hacia atras (testear)
        scrolledUnderElevation: 0.0, // la barra superior deberia ser 100% transparente ahora
        elevation: 0,
      ),
      
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),

            TextField(
              controller: bodyMsg,
              decoration: InputDecoration(
                hintText: 'Leave a comment!',
                border: OutlineInputBorder(

                ),
              ),
            ),

            const SizedBox(height: 20,),

            const SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                addMsg(bodyMsg.text.toString(), widget.b.id, widget.currentUser.id);
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
                    'Add message', 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}