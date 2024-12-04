import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:kartf1/models/cart.dart';
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
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => IntroPage()));
                      removeCart();
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

  void removeCart(){
    Provider.of<Cart>(context, listen: false).clearCart();
    // print("bORRADO");
  }

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