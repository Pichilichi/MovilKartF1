import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:http/http.dart';
import 'package:kartf1/django/urls.dart';
import 'package:kartf1/models/cart.dart';
import 'package:kartf1/models/equipments.dart';
import 'package:kartf1/models/users.dart';
import 'package:kartf1/pages/intro_page.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentpageState();
}

class _PaymentpageState extends State<PaymentPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String cardHolderName = '';
  String cvvCode = '';
  String expiryDate = '';
  Users cU = Urls.getUser();
  late (String, double) purchase;
  

  void PayTapped(){
    if (formKey.currentState!.validate()){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Confirm payment"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Card Holder: $cardHolderName"),
                Text("Card Number: $cardNumber"),
                Text("CVV: $cvvCode"),
                Text("Date of expiration: $expiryDate"),
              ],
            ),
          ),
          actions: [
            TextButton(
                    onPressed: () => Navigator.pop(context), 
                    child: const Text("Cancel")
                  ),

                  TextButton(
                    onPressed: () {(
                      purchase = Provider.of<Cart>(context, listen: false).addPurchase());
                      print(purchase);
                      addSH(purchase.$1,purchase.$2,cU.id);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => IntroPage()));
                      Provider.of<Cart>(context, listen: false).clearCart();
                      showDialog(
                      context: context, 
                      builder: (context) => const AlertDialog(
                        title: Text("Payment confirmed"),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              Text("Thanks for your patronage!"),
                            ],
                          ),
                        ), 
                      ));
                    },
                    child: Text("Yes")
                  ), 
          ],
        ));
    }
  }

  void addSH(String products, double finalPrice, currentUserId) async{

    try{

      Response response = await post(
        Uri.parse('https://pacou.pythonanywhere.com/shoppingHistory/'),
        body: {
          'products': products,
          'user': currentUserId.toString(),
          'totalPrice': finalPrice.toString(),
          'indvPrice': '0',
        }
      );

      if(response.statusCode == 201){
        var data = jsonDecode(response.body.toString());
        print('data added');
        print(data);
        
        // IntroPage(), prueba a ver si sale la barra de abajo asi
      }else{
        print('failed');
        showDialog(
          context: context, 
          builder: (context) => AlertDialog(
            title: Text('Something went wrong...'),
            content: Text('Check the data'),
          ),
        );
      }
    }catch(e){
      print(e.toString());
    }
  }

  // createPurchase(){
  //   List<Equipments> eq_Cart = Cart.getCart();
  //   print(eq_Cart);

  //   // for(int i = 0; i < c.length; i++){
  //   //   print(c[i].toString());
  //   // }
  // }

 

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        title: const Text("Checkout"),
      ),
      body: Column(
        children: [
          CreditCardForm(
            cardHolderName: cardHolderName,
            cardNumber: cardNumber,
            cvvCode: cvvCode,
            expiryDate: expiryDate,
            
            onCreditCardModelChange: (data) {
              setState(() {
                cardHolderName = data.cardHolderName;
                cardNumber = data.cardNumber;
                cvvCode = data.cvvCode;
                expiryDate = data.expiryDate;
              });
            },

            formKey: formKey,
          ),
        

          TextButton(
                onPressed: PayTapped,
                child: Text("Finish the payment")
          ),
        ],
      ),   
    ),
  );
  }
}