import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kartf1/models/bookings.dart';
import 'package:kartf1/models/messages.dart';
import 'package:kartf1/django/urls.dart';
import 'package:kartf1/models/users.dart';
import 'package:kartf1/pages/bookSelected_page.dart';
import 'package:kartf1/pages/intro_page.dart';


// USER OWN BOOKINGS CLASS
class BookPage extends StatefulWidget{
  const BookPage({super.key});

  @override
  _BookPageState createState() => _BookPageState();

}

// ADD BOOKING CLASS
class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key,});

  @override
  _AddBookPageState createState() => _AddBookPageState();

}

// OTHER USERS BOOKINGS CLASS
class OthersBookPage extends StatefulWidget {
  const OthersBookPage({super.key});

  @override
  State<OthersBookPage> createState() => _OthersBookPageState();
}



// USER OWN BOOKINGS PAGE
class _BookPageState extends State<BookPage> {
  Client client = http.Client();
  List<Booking>? books = [];
  List<Messages>? msg = [];
  List<Users>? users = [];
  Users cU = Urls.getUser();
  List<Messages> mensajes = [];
  var isLoaded = false;

  // The initial state of the page, also calls the api to retrieve data
  @override
  void initState(){
    super.initState();
    getData();
  }

  // Calls the api to get the specified data
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

    msg = await Urls().getMessages();
    if(msg != null){
      setState(() {
        isLoaded = true;
      });
    }
    
  }

  // Returns the owner of the booking
  getUser(List <Users>? user, int id){
    for(int i = 0; i < user!.length; i++){
      if(id == user[i].id){
        return user[i].username;
      }
    }
  }

  // Own bookings build
  @override
  Widget build(BuildContext context) {

    // Filter to get the bookings of the logged user
    final _filteredBooks = books
    ?.where((e) => e.user == cU.id).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(" My Bookings "),
        actions: [
          IconButton(
          icon: const Icon(Icons.add), 
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddBookPage()));
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

      body: Visibility(
        visible: isLoaded,

        replacement: const Center(
          child: CircularProgressIndicator(),
        ),

        // Checks if the list of bookings has data
        child: _filteredBooks!.isNotEmpty 
        ? ListView.builder(
          itemCount: _filteredBooks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_filteredBooks[index].name),
              subtitle: Text(" ${getUser(users, _filteredBooks[index].user)} "),
              onTap: () {                
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => BookSelectedPage(b: _filteredBooks[index], m: msg, u: users, currentUser:cU),
                  ),
                );
              },
            );
          },
        ) : const Center( child : (Text("You should create a booking!"))),       
      ),
    );
  }
}

// ADD BOOKING PAGE
class _AddBookPageState extends State<AddBookPage>{

  Users cU = Urls.getUser();
  List circuits = [];

  // The initial state of the page, also calls the api to retrieve data
  @override
  void initState(){
    super.initState();
    getData();
  }

  var isLoaded = false;

  // Get the specified data from the api
  getData() async {
    var baseUrl = 'https://pacou.pythonanywhere.com/circuits/';

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        circuits = jsonData;
      });
    }
  }

  DateTime selectedDate = DateTime.now();

  // Allows the user to pick a date for the booking
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Post a booking if the data is correct
  void addBooking(String bookName, raceDay, user, circuit) async{

    if(user.isEmpty || bookName.isEmpty || raceDay.isEmpty || circuit.isEmpty){
      showDialog(
        context: context, 
        builder: (context) => const AlertDialog(
          title: Text('Error'),
          content: Text('Fields cannot be blank'),
        ),
      );
    }else{
        try{
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => const IntroPage()));
          }else{
            showDialog(
              context: context, 
              builder: (context) => const AlertDialog(
                title: Text('Something went wrong...'),
                content: Text('Check the data'),
              ),
            );
          }

        }catch(e){
          print(e.toString());
        }
    }
  }

  TextEditingController nameBook = TextEditingController();
  TextEditingController raceDayBook = TextEditingController();
  TextEditingController circuitBook = TextEditingController();

  var dropdownvalue;

  // Add booking build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Add a booking "),
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
              controller: nameBook,
              decoration: const InputDecoration(
                hintText: 'Booking name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20,),


            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Select date'),
            ),

            DropdownButton(
              hint: const Text("Choose the circuit"),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: circuits.map((item) {
                return DropdownMenuItem(
                  value: item['id'].toString(),
                  child: Text(item['name']),
                );
              }).toList(),
             onChanged: (newVal) {
                setState(() {
                  dropdownvalue = newVal;
                });
              },
              value: dropdownvalue,
            ),

            const SizedBox(height: 20,),

            GestureDetector(
              onTap: () {
                addBooking(nameBook.text.toString(), selectedDate.toString().split(' ')[0], 
                cU.id.toString(), dropdownvalue.toString());
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
          ],
        ),
      ),
    );
  }
}

// OTHER USERS BOOKINGS PAGE
class _OthersBookPageState extends State<OthersBookPage> {
 Client client = http.Client();
  List<Booking>? books = [];
  List<Messages>? msg = [];
  List<Users>? users = [];
  Users cU = Urls.getUser();
  List<Messages> mensajes = [];
  var isLoaded = false;

  // The initial state of the page, also calls the api to retrieve data
  @override
  void initState(){
    super.initState();
    getData();
  }

  // Calls the api and gets the specified data
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

    msg = await Urls().getMessages();
    if(msg != null){
      setState(() {
        isLoaded = true;
      });
    }
  }

  // Gets the booking owner
  getUser(List <Users>? user, int id){
    for(int i = 0; i < user!.length; i++){
      if(id == user[i].id){
        return user[i].username;
      }
    }
  }

  // Others booking build
  @override
  Widget build(BuildContext context) {

    // Filter to get the bookings where the logged user has been added as a racer
    final _filteredBooks = books
    ?.where((e) => e.racers.contains(cU.id)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(" Others Bookings "),
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

      body: Visibility(
        visible: isLoaded,

        replacement: const Center(
          child: CircularProgressIndicator(),
        ),

        // Checks if there is a booking where the user has been invited
        child: _filteredBooks!.isNotEmpty 
        ? ListView.builder(
          itemCount: _filteredBooks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_filteredBooks[index].name),
              subtitle: Text(" ${getUser(users, _filteredBooks[index].user)} "),
              onTap: () {  
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => BookSelectedPage(b: _filteredBooks[index], m: msg, u: users, currentUser:cU),
                  ),
                );
              },
            );
          },
          
        ) : const Center( child : (Text("No invitations... for now :)"))),
      ),     
    );
  }
}