import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kartf1/models/cart.dart';
import 'package:kartf1/models/equipments.dart';
import 'package:kartf1/models/photo.dart';
import 'package:kartf1/models/shoppingHistory.dart';
import 'package:kartf1/models/users.dart';
import 'package:provider/provider.dart';
import '../django/urls.dart';

// EQUIPMENT CLASS
class EquipPage extends StatefulWidget {
  const EquipPage( {Key? key}) : super(key: key);

  @override
  State<EquipPage> createState() => _EquipPageState();
} 

// EQUIPMENT PAGE
class _EquipPageState extends State<EquipPage>{

  var _nameCat = "GL";
  Client client = http.Client();
  List<Equipments>? eq = [];
  List<Photo>? ph = [];

  var isLoaded = false;

  // The initial state of the page, also calls the api to retrieve data
  @override
  void initState(){
    // _retrieveEvents();
    super.initState();
    getData();
  }

  // Calls the api to get the specified data
  getData() async {
    eq = await Urls().getEquipments();
    if(eq != null){
      setState(() {
        isLoaded = true;
      });
    }
  }

  // Adds the equipments that we send to the Cart
  void addEquipToCart(Equipments eq){
    Provider.of<Cart>(context, listen: false).addItemToCart(eq);
    showDialog(
      context: context, 
      builder: (context) => const AlertDialog(
        title: Text('Succesfuly added'),
        content: Text('Check your cart'),
      ),
    );
  }

  // Equipment build
  @override
  Widget build(BuildContext context){

    // Filters the equipment based on the category
    final _filteredEq = eq
    ?.where((e) => e.equipmentCategory == _nameCat).toList();

    return Consumer<Cart>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Shop"),
          actions: [
            IconButton(
              icon: const Icon(Icons.manage_history_outlined), 
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const UserPurchase()));
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

        body: Column(
          children: [
            Container (
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              
              // Filter options
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

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 25.0),
              child: Text(
                'The best equipment for your races!',  
                style: TextStyle(color: Colors.black),
              ),
            ),

            
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
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

            // List of Equipments for sale
            Expanded(
              child: ListView.builder(
                itemCount: _filteredEq?.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 25),
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

                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _filteredEq[index].name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                          
                                  const SizedBox(height: 5),

                                  Text(
                                    '${_filteredEq[index].price}€' ,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),

                                  Text(
                                    '${_filteredEq[index].stock} units left' ,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                          
                              GestureDetector(
                                onTap: () => addEquipToCart(_filteredEq[index]),
                                child: Container(
                                  padding: const EdgeInsets.all(25),
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

// EQUIPMENT CATEGORY CLASS
class EqCat extends StatelessWidget {
  final String text;
  final bool? selected;
  final VoidCallback onPressed;
  const EqCat(
    this.text, {
    super.key,
    required this.onPressed,
    this.selected,
  });

  // Equipment category build
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

// PURCHASE HISTORY CLASS
class UserPurchase extends StatefulWidget {
  const UserPurchase({super.key});

  @override
  State<UserPurchase> createState() => _UserPurchasesState();
}

// PURCHASE HISTORY PAGE
class _UserPurchasesState extends State<UserPurchase> {

  List<ShoppingHistory>? sH = [];
  Users cU = Urls.getUser();
  var isLoaded = false;

  // Calls the api to get previous purchases
  getData() async {
      sH = (await Urls().getPurchases());
      if(sH != null){
        setState(() {
          isLoaded = true;
        });
      }
  }

  // The initial state of the page, also calls the api to retrieve data
  @override
  void initState(){
    super.initState();
    getData();
  }

  // Returns the purchases made by the actual logged user
  allPurchases(){
    List<ShoppingHistory> SH = [];
    for(int i = 0; i < sH!.length; i++){
      if(sH![i].user == cU.id){
        SH.add(sH![i]);
      }
    }
    return SH;
  }

  // Purchase history build 
  @override
  Widget build(BuildContext context) {

    List<ShoppingHistory> SH = allPurchases();

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Purchase history"),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold, 
          fontSize: 24, 
          color: Colors.black),
      ),

      backgroundColor: Colors.white,

      // If purchase history has a record, shows it. If not, displays a message
      body: SH.isNotEmpty 
      ? Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: SH.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(SH[index].products),
                  subtitle: Text("${SH[index].created.day}/${SH[index].created.month}/${SH[index].created.year} - ${SH[index].created.hour}:${SH[index].created.minute}"),
                  trailing: Text("${SH[index].totalPrice.toStringAsFixed(2)}\u{20AC}"), 
                );
              },
            ),
          ),
        ],
      ) : const Center(child: Text("Nothing here, man")),
    );
  }
}
