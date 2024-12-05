import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kartf1/components/Equipment_tile.dart';
import 'package:kartf1/components/nav_bar.dart';
import 'package:kartf1/models/cart.dart';
import 'package:kartf1/models/equipments.dart';
import 'package:kartf1/models/photo.dart';
import 'package:kartf1/models/shoppingHistory.dart';
import 'package:kartf1/models/users.dart';
import 'package:kartf1/pages/Cart_page.dart';
import 'package:kartf1/pages/intro_page.dart';
import 'package:provider/provider.dart';

import '../django/urls.dart';
import 'Book_page.dart';

class EquipPage extends StatefulWidget {
  const EquipPage( {Key? key}) : super(key: key);

  @override
  State<EquipPage> createState() => _EquipPageState();
} 

class _EquipPageState extends State<EquipPage>{

  var _nameCat = "GL";
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

    final _filteredEq = eq
    ?.where((e) => e.equipmentCategory == _nameCat).toList();

    return Consumer<Cart>(
      builder: (context, value, child) => Scaffold(

        backgroundColor: Colors.white,
        appBar: AppBar(
        title: Text("Shop"),
        actions: [
          IconButton(
          icon: Icon(Icons.manage_history_outlined), 
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => userPurchase()));
          },
         ),
        ],
        // actions: [
        //   IconButton(
        //   icon: Icon(Icons.arrow_back), 
        //   onPressed: (){
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage()));
        //   },
        //  ),
        // ],
        
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, // cambia lo del boton hacia atras (testear)
        scrolledUnderElevation: 0.0, // la barra superior deberia ser 100% transparente ahora
        elevation: 0,
      ),

        body: Column(

        
        children: [

          Container (
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EqCat(
                'Gloves',
                onPressed: () => setState(() => _nameCat = "GL"),
                selected: _nameCat == "GL",
              ),
              EqCat(
                'Helmet',
                onPressed: () => setState(() => _nameCat = "HM"),
                selected: _nameCat == "HM",
              ),
              EqCat(
                'Suits',
                onPressed: () => setState(() => _nameCat = "RS"),
                selected: _nameCat == "RS",
              ),
            ],
            ),
          ),

          // MESSAGE BELOW SEARCHBAR
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              'The best equipment for your races!',  
              style: TextStyle(color: Colors.black),
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
              itemCount: _filteredEq?.length,
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
                        
                      AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: double.infinity,
                        padding: const EdgeInsets.all(23),
                        child: Image.network("https://pacou.pythonanywhere.com${_filteredEq![index].img}"),
                      )
                      ),
                      // Text(
                      //   _filteredEq![index].name,
                      //   style: TextStyle(color: Colors.grey[600]),
                      // ),

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
                                  _filteredEq![index].name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                        
                                const SizedBox(height: 5),

                                // PRICE
                                Text(
                                  _filteredEq![index].price.toString() + '\€' ,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),

                                // STOCK
                                Text(
                                  _filteredEq![index].stock.toString() + ' units left' ,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                        
                            // BUTTON +
                            GestureDetector(
                              onTap: () => addEquipToCart(_filteredEq![index]),
                              child: Container(
                                padding: EdgeInsets.all(25),
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
      ),
    );
  }
}

class EqCat extends StatelessWidget {
  final String text;
  final bool? selected;
  final VoidCallback onPressed;
  const EqCat(
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
              selected == true ? Theme.of(context).colorScheme.primary : null,
          fontWeight: selected == true ? FontWeight.bold : null,
        ),
      ),
    );
  }
}

class userPurchase extends StatefulWidget {
  const userPurchase({super.key});

  @override
  State<userPurchase> createState() => _userPurchasesState();
}

class _userPurchasesState extends State<userPurchase> {

  List<ShoppingHistory>? sH = [];
  Users cU = Urls.getUser();
  var isLoaded = false;

getData() async {
    sH = (await Urls().getPurchases());
    if(sH != null){
      setState(() {
        isLoaded = true;
      });
    }
}

@override
  void initState(){
    // _retrieveEvents();
    super.initState();

    getData();
  }

  allPurchases(){
    List<ShoppingHistory> SH = [];
    for(int i = 0; i < sH!.length; i++){
      if(sH![i].user == cU.id){
        SH.add(sH![i]);
      }
    }
    return SH;
  }

  //currentUser.id == b.user 
  
  @override
  Widget build(BuildContext context) {
    List<ShoppingHistory> SH = allPurchases();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Purchase history"),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        
      ),

      backgroundColor: Colors.white,
      body: SH.isNotEmpty 
      ? Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: SH.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(SH[index].products),
                  subtitle: Text(SH[index].created.toString()),
                  trailing: Text(SH[index].totalPrice.toString()),
                  
                  //subtitle: Text(M[index].user.toString())
                  // subtitle: Text(" ${getUser(u, M[index].user)} "),
                  //trailing: currentUser.id == M[index].user 
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
