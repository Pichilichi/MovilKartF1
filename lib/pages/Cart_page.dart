import 'package:flutter/material.dart';
import 'package:kartf1/components/cart_item.dart';
import 'package:kartf1/models/cart.dart';
import 'package:kartf1/models/equipments.dart';
import 'package:kartf1/pages/Payment_page.dart';
import 'package:provider/provider.dart';

// CART PAGE
class CartPage extends StatelessWidget {
  const CartPage({super.key});
  
  // Cart build
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0.0, 
          elevation: 0,
        ),

        backgroundColor: Colors.white,

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const SizedBox(height: 20),

              // Checks if the cart is empty
              Expanded(
                child: value.getUserCart().isNotEmpty 
                  ? ListView.builder(
                  itemCount: value.getUserCart().length,
                  itemBuilder:  (context, index) {
                    Equipments eq = value.getUserCart()[index];
                    return CartItem(equip: eq,);
                  } 
                ) : const Center( child : (Text("Wow! So empty"))),
              ),

              // Payment button. If the cart is empty, shows message and does not proceed to the payment
              GestureDetector(
                onTap: () {
                  if (value.getUserCart().isEmpty){

                    const sb = SnackBar(
                      content: Text("The cart is empty, try adding something!"),
                      duration: Duration(milliseconds: 2000),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(sb);
                    
                  }else{
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const PaymentPage()),
                    ); 
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
                    child: Text('Payment!', 
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