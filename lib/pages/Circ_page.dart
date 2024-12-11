
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kartf1/models/categories.dart';
import 'package:kartf1/models/circuits.dart';
import 'package:kartf1/django/urls.dart';
import 'package:kartf1/pages/circuitSelected_page.dart';

// CIRCUIT CLASS
class CircPage extends StatefulWidget{
  const CircPage({super.key});

  @override
  _CircPageState createState() => _CircPageState();
}
 
// CIRCUIT PAGE
class _CircPageState extends State<CircPage> {

  var _nameCat = 1;
  Client client = http.Client();
  List<Circuits>? circuits = [];
  List<Categories>? categories = [];
  var isLoaded = false;

  // The initial state of the page, also calls the api to retrieve data
  @override
  void initState(){
    super.initState();
    getData();
  }

  // Calls the api to get the specified data
  getData() async {
    circuits = await Urls().getCircuits();
    categories = await Urls().getCategories();

    if(circuits != null){
      setState(() {
        isLoaded = true;
      });
    }

    if(categories != null){
      setState(() {
        isLoaded = true;
      });
    }
  }

  // Circuits build
  @override
  Widget build(BuildContext context) {

    // Circuits filter based on their category
    final circuitos = circuits
    ?.where((c) => c.category == _nameCat).toList();

    return Scaffold( 
      appBar: AppBar(
        title: const Text("Circuits"),
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

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
            itemCount: circuitos?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(circuitos![index].name),
                subtitle: Text("${circuitos[index].km} km"),
                tileColor: Colors.grey[100],
                leading: CountryFlag.fromCountryCode(
                  circuitos[index].flag,  
                  shape: const RoundedRectangle(6),
                ),
              
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                    builder: (context) => CircuitSelectedPage(c: circuitos[index]),
                    ),
                  );
                },
              );
            },
          ),
        ),
        
        // Filter options
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CatButton(
                'Europe',
                onPressed: () => setState(() => _nameCat = 1),
                selected: _nameCat == 1,
              ),
              CatButton(
                'America',
                onPressed: () => setState(() => _nameCat = 2),
                selected: _nameCat == 2,
              ),
              CatButton(
                'Asia',
                onPressed: () => setState(() => _nameCat = 4),
                selected: _nameCat == 4,
              ),
              CatButton(
                'Oceania',
                onPressed: () => setState(() => _nameCat = 5),
                selected: _nameCat == 5,
              ),
              CatButton(
                'Africa',
                onPressed: () => setState(() => _nameCat = 6),
                selected: _nameCat == 6,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// CIRCUIT CATEGORY CLASS
class CatButton extends StatelessWidget {
  final String text;
  final bool? selected;
  final VoidCallback onPressed;
  const CatButton(
    this.text, {
    super.key,
    required this.onPressed,
    this.selected,
  });

  // Circuit category build
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        '$text \n____________',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11,
          color:
              selected == true ? Colors.indigo : null,
              fontWeight: selected == true ? FontWeight.bold : null,
        ),
      ),
    );
  }
}
