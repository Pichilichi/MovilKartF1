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
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My cart',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: value.getUserCart().length,
                itemBuilder: (context, index) {
                  
                  Equipments eq = value.getUserCart()[index];

                  return CartItem(equip: eq,);
                },
              ),
            ),

            TextButton(
              onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => const PaymentPage(),
                )), 
              child: Text("Payment!"))
          ],  
        ),
      ),
    );
  }
}