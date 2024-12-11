import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:http/http.dart';
import 'package:kartf1/django/urls.dart';
import 'package:kartf1/models/cart.dart';
import 'package:kartf1/models/users.dart';
import 'package:kartf1/pages/intro_page.dart';
import 'package:provider/provider.dart';

// PAYMENT CLASS
class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentpageState();
}

// PAYMENT PAGE
class _PaymentpageState extends State<PaymentPage> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String cardHolderName = '';
  String cvvCode = '';
  String expiryDate = '';
  Users cU = Urls.getUser();
  late (String, double) purchase;
  
  // Checks the Payment form
  // if it is okay: Creates a copy on the user purchase history, goes back to the first page and clears the cart
  // if it is not okay, asks to input the data correctly
  void PayTapped(){
    if (formKey.currentState!.validate() && cardHolderName.isNotEmpty){
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
                  )
                );
              },
              child: Text("Yes")
            ), 
          ],
        )
      );
    }else{
      showDialog(
        context: context, 
        builder: (context) => const AlertDialog(
          title: Text("The name cannot be blank"),
          content: Text("Please check it again")
        )
      );
    }
  }

  // Calls the api to create a purchase history 
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

      }else{
        showDialog(
          context: context, 
          builder: (context) => const AlertDialog(
            title: Text('Something went wrong...'),
            content: Text('Check the data'),
          ),
        );
      }

    }catch(e){
      print(e.toString());
    }
  }

  // Payment build
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 24, 
            color: Colors.black
          ),
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
                  child: const Text("Finish the payment")
            ),

          ],
        ),   
      ),
    );
  }
}