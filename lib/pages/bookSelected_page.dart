import 'package:flutter/material.dart';
import 'package:kartf1/models/bookings.dart';
import 'package:kartf1/models/messages.dart';
import 'package:kartf1/models/users.dart';
import 'package:kartf1/pages/Book_page.dart';
import 'package:kartf1/pages/intro_page.dart';

class bookSelectedPage extends StatelessWidget {
  const bookSelectedPage({super.key, required this.b, required this.m, required this.u});

  final Booking b;
  final m;
  final List <Users>? u;

  allMesagges(){
    List<Messages> M = [];
    for(int i = 0; i < m.length; i++){
      //print(m[i]);
      M.add(m[i]);
      //print(M[i].body);
      
    }
    print(M);
    return M;

    
  }

  getUser(List <Users>? user, int id){
    for(int i = 0; i < user!.length; i++){
      if(id == user[i].id){
        return user[i].username;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    List<Messages> M = allMesagges();
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(b.name),
        actions: [
          IconButton(onPressed: () {
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
                    onPressed: () {
                      allMesagges();
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => IntroPage()));
                      // el borrarlo de la api
                    },
                    child: Text(b.id.toString())
                  ), //id del booking para borrarlo
                ],
              )
            );
          }, icon: const Icon (Icons.delete))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: M.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(M[index].body),
                  //subtitle: Text(M[index].user.toString())
                  subtitle: Text(" ${getUser(u, M[index].user)} "),
                );
              },
            ),
          ),
          Text("Number of participants: ${b.racers.length} "),
          Text("${M}"),

        ],
         
      ),
      
    );
  }
}