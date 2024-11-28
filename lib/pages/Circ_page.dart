
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kartf1/models/categories.dart';
import 'package:kartf1/models/circuits.dart';
import 'package:kartf1/django/urls.dart';
import 'package:kartf1/pages/circuitSelected_page.dart';


class CircPage extends StatefulWidget{
  const CircPage({Key? key}) : super(key: key);

  @override
  _CircPageState createState() => _CircPageState();
}

// class PruebaPage extends StatefulWidget {
//   const PruebaPage({super.key});

//   @override
//   _PruebaPageState createState() => _PruebaPageState();

// }

 

class _CircPageState extends State<CircPage> {
  var _nameCat = 1;
  Client client = http.Client();
  List<Circuits>? circuits = [];
  List<Categories>? categories = [];
  var isLoaded = false;

  @override
  void initState(){
    // _retrieveEvents();
    super.initState();

    getData();
  }

  // var bandera = CountryFlag.fromCountryCode('ES', 
  // shape: const Circle());

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

  // @override
  //  Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.grey[300],
  //     body: Visibility(
  //       visible: isLoaded, 
  //       child: GestureDetector(
  //         onTap: () {
  //           Navigator.push(context, MaterialPageRoute(builder: (context) => PruebaPage()));
  //         },
  //         child: Hero(
  //           tag: "hero",
  //           child: Image.network("https://picsum.photos/250?image=9"),
  //         ),
  //       ),
          
  //     ),
  //   );
  // }



  @override
  Widget build(BuildContext context) {

    // Filtro
    final circuitos = circuits
    ?.where((c) => c.category == _nameCat).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Circuits"),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, // cambia lo del boton hacia atras (testear)
        scrolledUnderElevation: 0.0, // la barra superior deberia ser 100% transparente ahora
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
            itemCount: circuitos?.length,
            itemBuilder: (context, index) {
              return ListTile(
              title: Text(circuitos![index].name),
              subtitle: Text(circuitos![index].km + " km"),
              tileColor: Colors.grey[100],
              
              leading: CountryFlag.fromCountryCode(circuitos![index].flag,  //Añadir campo CountryCode a circuitos
                shape: const RoundedRectangle(6),
                ),
              
              // subtitle: Text(categories![circuitos![index].category-1].name),  Devuelve el continente
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                    builder: (context) => circuitSelectedPage(c: circuitos![index]),
                    ),
                  );
                },
              );
            },
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
              //               circuits![index].name, //CIRCUITS
              //               maxLines: 2,
              //               overflow: TextOverflow.ellipsis,
              //               style: TextStyle(
              //                 fontSize: 24,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //             Text(
              //               circuits![index].body, //DESCRIPTION
              //               maxLines: 20,
              //               overflow: TextOverflow.ellipsis,
              //             ),
              //             Text(
              //               'Track length : '  +
              //               circuits![index].km.toString() + ' km',
              //               //DATE
              //               maxLines: 1,
              //               overflow: TextOverflow.ellipsis,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              //   // child: Text(events![index].name), //BOOKINGS
              // );
          
        ),
        ),
        
        
        
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

class CatButton extends StatelessWidget {
  final String text;
  final bool? selected;
  final VoidCallback onPressed;
  const CatButton(
    this.text, {
    Key? key,
    required this.onPressed,
    this.selected,
  }) : super(key: key);

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

// class _PruebaPageState extends State<PruebaPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Hero(
//           tag: "hero",
//           child: Image.network("https://picsum.photos/250?image=9"),
//         ),
//       ),
//     );
//   }
//  }

 