import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kartf1/components/Equipment_tile.dart';
import 'package:kartf1/components/nav_bar.dart';
import 'package:kartf1/models/cart.dart';
import 'package:kartf1/models/equipments.dart';
import 'package:kartf1/models/photo.dart';
import 'package:provider/provider.dart';

import '../django/urls.dart';
import 'Book_page.dart';

class EquipPage extends StatefulWidget {
  const EquipPage( {Key? key}) : super(key: key);

  @override
  State<EquipPage> createState() => _EquipPageState();
} 

class _EquipPageState extends State<EquipPage>{

  Client client = http.Client();
  List<Equipments>? eq = [];
  List<Photo>? ph = [];

  var isLoaded = false;

   @override
  void initState(){
    // _retrieveEvents();
    super.initState();

    getData();
  }

  getData() async {
    eq = await Urls().getEquipments();
    if(eq != null){
      setState(() {
        isLoaded = true;
      });
    }
  }

  void addEquipToCart(Equipments eq){
    Provider.of<Cart>(context, listen: false).addItemToCart(eq);

    // AlertMessage
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text('Succesfuly added'),
        content: Text('Check your cart'),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Consumer<Cart>(
      builder: (context, value, child) => Column(
        children: [
          Container (
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Search',
                  style: TextStyle(color: Colors.grey),
                ),
                Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ],
            ),
          ),

          // MESSAGE BELOW SEARCHBAR
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              'The best equipment for your races!',  
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),

          // EQUIPMENT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Best sellers',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // LIST OF EQUIPMENT FOR SALE
          Expanded(
            child: ListView.builder(
              itemCount: eq?.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(left: 25),
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text(
                        eq![index].name,
                        style: TextStyle(color: Colors.grey[600]),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [


                                // NAME
                                Text(
                                  eq![index].name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                        
                                const SizedBox(height: 5),

                                // PRICE
                                Text(
                                  eq![index].price.toString() + '\€' ,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                        
                            // BUTTON +
                            GestureDetector(
                              onTap: () => addEquipToCart(eq![index]),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                    ],
                  ),

                  
                );
              } ,
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(top: 25.0, left: 25, right: 25),
            child: Divider(
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
