import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kartf1/models/bookings.dart';
import 'package:kartf1/models/messages.dart';
import 'package:kartf1/models/users.dart';
import 'package:kartf1/pages/intro_page.dart';

// SELECTED BOOKING CLASS
class BookSelectedPage extends StatelessWidget {
  const BookSelectedPage({super.key, required this.b, required this.m, 
  required this.u, required this.currentUser, this.dropdownvalue,});

  final Booking b;
  final m;
  final List <Users>? u;
  final Users currentUser;

  // Returns all the messages for the specified booking
  allMesagges(){
    List<Messages> M = [];
    for(int i = 0; i < m.length; i++){
      if(b.id == m[i].booking){
        M.add(m[i]);
      }
    }
    return M;
  }

  // Returns the user who created the message
  getUser(List <Users>? user, int id){
    for(int i = 0; i < user!.length; i++){
      if(id == user[i].id){
        return user[i].username;
      }
    }
  }

  // Gets the users who are not part of a booking (Not a racer) and excludes himself
  getUsers(){
    List us = [];
    for(int i = 0; i < u!.length; i++){
      if(b.racers.contains(u![i].id) == false && currentUser.id != u![i].id){
        us.add(u![i]);
      }
    }
    return us;
  }

  // Deletes the booking
  Future<void> deleteBooking() async {
    try{
      Response response = await delete(
        Uri.parse("https://pacou.pythonanywhere.com/bookings/${b.id}")
      );

      if(response.statusCode == 204){
        
      }
      
    }catch(e){
      print(e);
    }
  }

  // Deletes a message
  Future<void> deleteMsg(int m) async {

    try{
      Response response = await delete(
        Uri.parse("https://pacou.pythonanywhere.com/messages/${m}"),

      );

      if(response.statusCode == 204){
        //print("Borrado");
      }
      
    }catch(e){
      print(e);
    }
  }

  // Adds a user to the booking
  Future<void> addRacer(var id) async {
    try{
      Response response = await put(
        Uri.parse("https://pacou.pythonanywhere.com/bookings/${b.id}"),
        body: {
          'opt' : 'add',
          'racers' : id
        }
      );

      if(response.statusCode == 200){
        
      }

    }catch(e){
      print(e);
    }
  }
  
  Future<void> eraseRacer(var id) async {
    print(id);
    try{
      Response response = await put(
        Uri.parse("https://pacou.pythonanywhere.com/bookings/${b.id}"),
        body: {
          'opt' : 'out',
          'racers' : id
        }
      );

      if(response.statusCode == 200){
        
      }

    }catch(e){
      print(e);
    }
  }


  final dropdownvalue;
  
  // Selected booking build
  @override
  Widget build(BuildContext context) {

    List<Messages> M = allMesagges();
    List us = getUsers();
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("${b.name} ${b.raceDay.day}/${b.raceDay.month}"),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold, 
          fontSize: 24, 
          color: Colors.black
        ),
        actions: [
          // Checks if the user who pressed the delete button is the creator of the booking
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
                      const sb = SnackBar(
                        content: Text("Booking deleted!"),
                        duration: Duration(milliseconds: 2000),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(sb);
                      await Navigator.push(context, MaterialPageRoute(builder: (context) => const IntroPage()));
                    },
                    child: const Text("Delete")
                  ), 

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
  
          icon: const Icon (Icons.delete)),

          IconButton(
          icon: const Icon(Icons.add), 
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddMsgPage(b : b, currentUser: currentUser,)));
          },
         ),
        ],
      ),
      
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child:  M.isNotEmpty 
            ? ListView.builder(
                itemCount: M.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(M[index].body),
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
            ) : const Center(child: Text("Nothing here, man")),
          ),
          currentUser.id == b.user 
          ? DropdownButton(
              hint: const Text("Add a racer!"),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: us.map((item) {
                return DropdownMenuItem(
                  value: item.id.toString(),
                  child: Text(item.username.toString()),
                );
              }
            ).toList(),

            onChanged: (newVal) {
              showDialog(
                context: context, 
                builder: (context) => AlertDialog(
                  title: const Text('Racer added!'),
                  content: const Text('Access to the booking has been granted'),
                  actions: [
                    TextButton(
                      onPressed: Navigator.of(context).pop, 
                      child: const Text("Hooray!")
                    )
                  ],
                ),  
              );
              addRacer(newVal);
            },
              value: dropdownvalue,
          ) : IconButton(
            onPressed: (){
              eraseRacer(currentUser.id.toString());
              Navigator.push(context, MaterialPageRoute(builder: (context) => const IntroPage()));
            }, 
            icon: const Icon(Icons.door_back_door_outlined))
        ],
      ),
    );
  }
}

// ADD MESSAGE CLASS
class AddMsgPage extends StatefulWidget {
  const AddMsgPage({super.key, required this.b, required this.currentUser});

  final Booking b;
  final Users currentUser;

  @override
  _AddMsgPageState createState() => _AddMsgPageState();

}

// ADD MESSAGE PAGE
class _AddMsgPageState extends State<AddMsgPage>{


// Post a message on te selected booking
void addMsg(String bodyMsg, bookingId, currentUserId) async{

    try{
      Response response = await post(
        Uri.parse('https://pacou.pythonanywhere.com/messages/'),
        body: {
          'body': bodyMsg,
          'user': currentUserId.toString(),
          'booking': bookingId.toString(),
        }
      );

      if(response.statusCode == 201){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const IntroPage()));
      }else{
        showDialog(
          context: context, 
          builder: (context) => const AlertDialog(
            title:  Text('Something went wrong...'),
            content: Text('Check the data'),
          ),
        );
      }
    }catch(e){
      print(e.toString());
    }
  }

  TextEditingController bodyMsg = TextEditingController();

  // Add message build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Add a message! "),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back), 
            onPressed: (){
              Navigator.pop(context, MaterialPageRoute(builder: (context) => const IntroPage()));
            },
          ),
        ],
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold, 
          fontSize: 24, 
          color: Colors.black
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, 
        scrolledUnderElevation: 0.0, 
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
              decoration: const InputDecoration(
                hintText: 'Leave a comment!',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 40,),
            
            GestureDetector(
              onTap: () {
                addMsg(bodyMsg.text.toString(), widget.b.id, widget.currentUser.id);
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