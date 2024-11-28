import 'package:flutter/material.dart';
import 'package:kartf1/components/cart_item.dart';
import 'package:kartf1/models/cart.dart';
import 'package:kartf1/models/equipments.dart';
import 'package:kartf1/pages/Payment_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Scaffold(
      backgroundColor: Colors.white,

        appBar: AppBar(
        title: Text("Cart"),
        // actions: [
        //   IconButton(
        //   icon: Icon(Icons.arrow_back), 
        //   onPressed: (){
        //     Navigator.pop(context, MaterialPageRoute(builder: (context) => IntroPage()));
        //   },
        //  ),
        // ],
        
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, // cambia lo del boton hacia atras (testear)
        scrolledUnderElevation: 0.0, // la barra superior deberia ser 100% transparente ahora
        elevation: 0,
      ),

        body: Padding(

        
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            

            const SizedBox(height: 20),

            Expanded(
              child: value.getUserCart().length > 0 
                ? ListView.builder(
                itemCount: value.getUserCart().length,
                itemBuilder:  (context, index) {
                  
                  Equipments eq = value.getUserCart()[index];

                  return CartItem(equip: eq,);
                } 
              ) : const Center( child : (Text("Wow! So empty"))),
            ),

            // Payment button. If cart empty, shows message and doesnt change pages
            GestureDetector(
              
                onTap: () {
                  if (value.getUserCart().length == 0){
                    null;
                    final sb = SnackBar(content: 
                    Text("The cart is empty, try adding something!"),
                    duration: const Duration(milliseconds: 2000),);
                    ScaffoldMessenger.of(context).showSnackBar(sb);
                  }else{
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) 
                      => const PaymentPage(),
                    )); 
                  }
                },
                child: Container (
                  alignment: Alignment.center,
                  height: 45,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      'Payment!', 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
            ),

            const SizedBox(height: 5),
          ]  
        ),
        ),
      ),
    );
  }
}