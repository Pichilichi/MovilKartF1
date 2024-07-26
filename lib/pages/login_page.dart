import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kartf1/pages/intro_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

}




class _LoginPageState extends State<LoginPage>{

  TextEditingController userController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  
  get existe => null;



  void login(String user, password) async{

  try{

    Response response = await post(
      Uri.parse('https://pacou.pythonanywhere.com/login'),
      body: {
        'username': user,
        'password': password,
      }
    );

    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      print('account logged');
      // print(data);
      Navigator.push(context, MaterialPageRoute(builder: (context) => IntroPage()));
    }else{
      print('failed');
      showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text('Something went wrong...'),
        content: Text('Check your credentials'),
      ),
    );
    }
  }catch(e){
    print(e.toString());
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.lock,
              size: 100,
            ),

            const SizedBox(height: 50),

            TextField(
              controller: userController,
              decoration: InputDecoration(
                hintText: 'username',
                border: OutlineInputBorder(

                ),
              ),
            ),

            const SizedBox(height: 20,),


            TextField(
              obscureText: true,
              controller: pwdController,
              decoration: InputDecoration(
                hintText: 'password',
                border: OutlineInputBorder(

                ),
              ),
            ),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                login(userController.text.toString(), pwdController.text.toString());
                // Navigator.push(context, MaterialPageRoute(builder: (context) => IntroPage())); 
              },
              child: Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'Sign Up', 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              child: const Text('Open route'),
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Register()),
              );
}
            ),
          ],
        ),
      ),
    );
  }
  
}

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
       body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.grey[300],
  //     body: Padding(
  //       padding: const EdgeInsets.all(8),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Icon(
  //             Icons.lock,
  //             size: 100,
  //           ),

  //           const SizedBox(height: 50),

  //           TextField(
  //             decoration: InputDecoration(
  //               hintText: 'username',
  //               border: OutlineInputBorder(

  //               ),
  //             ),
  //           ),

  //           const SizedBox(height: 20,),


  //           TextField(
  //             obscureText: true,
  //             decoration: InputDecoration(
  //               hintText: 'password',
  //               border: OutlineInputBorder(

  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 20,),
  //           GestureDetector(
  //             onTap: () {
  //               login(userController.text.toString(), pwdController.text.toString());
  //               Navigator.push(context, MaterialPageRoute(builder: (context) => IntroPage())); 
  //             },
  //             child: Container(
  //               height: 60,
  //               width: 300,
  //               decoration: BoxDecoration(
  //                 color: Colors.black,
  //                 borderRadius: BorderRadius.circular(30),
  //               ),
  //               child: const Center(
  //                 child: Text(
  //                   'Sign Up', 
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 18,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}