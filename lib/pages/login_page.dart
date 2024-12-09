import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kartf1/pages/intro_page.dart';

import '../django/urls.dart';
import '../models/users.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();

}


class _LoginPageState extends State<LoginPage>{

  TextEditingController userController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  
  Urls u = Urls();
  
  get existe => null;



login(String user, password) async{

 

  try{

    Response response = await post(
      Uri.parse('https://pacou.pythonanywhere.com/login'),
      body: {
        'username': user,
        'password': password,
      }
    );


    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      // print('account logged');
      // print(data.keys);
      List l = data.values.toList();
      print("listado");
      print(data);
      print(l);
      int id = l[0];
      String name = l[1];
      print(name);
      // for(var key ){
      // print (usersFromJson(data));

      // }
      Navigator.push(context, MaterialPageRoute(builder: (context) => IntroPage()));
      u.setUser(name,id);
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
        appBar: AppBar(
        title: Text("Welcome back!"),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, 
        fontSize: 36, 
        color: Colors.black,),
        toolbarHeight: 40,
        
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, 
        scrolledUnderElevation: 0.0, // la barra superior deberia ser 100% transparente ahora
        elevation: 0,
        centerTitle: true,
        
      ),

      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(4),

        
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


            Image.asset('assets/images/transparente.png'),


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

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
              onTap: () {
                login(userController.text.toString(), pwdController.text.toString());
                // Navigator.push(context, MaterialPageRoute(builder: (context) => IntroPage())); 
              },
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'Login', 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),

          const SizedBox(width: 20,),

            GestureDetector(
              onTap: (){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterPage()));
              },
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'New user', 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),

              ],
            ),
            
            

          ],
        ),
      ),
    );
  }
  
}

class _RegisterPageState extends State<RegisterPage> {

  void register(String user, password) async{

  try{

    Response response = await post(
      Uri.parse('https://pacou.pythonanywhere.com/register'),
      body: {
        'username': user,
        'password': password,
      }
    );

    if(response.statusCode == 201){
      var data = jsonDecode(response.body.toString());
      print('account registered');
      // print(data);
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text('Account created!'),
        content: Text('Log in with your new account'),
      ),
      );
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

  TextEditingController userReg = TextEditingController();
  TextEditingController pwdReg = TextEditingController();


  // @override
  // Widget build(BuildContext context){
  //   return Scaffold(
  //      body: Center(
  //       child: ElevatedButton(
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //         child: const Text('Go back!'),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nice to meet you!"),
        
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, 
        fontSize: 36, 
        color: Colors.black,),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, 
        scrolledUnderElevation: 0.0, // la barra superior deberia ser 100% transparente ahora
        elevation: 0,
        centerTitle: true,
        
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Let's register you first! "),

            const SizedBox(height: 50),

            TextField(
              obscureText: false,
              // controller: pwdReg,
              decoration: InputDecoration(
                hintText: 'Fullname',
                border: OutlineInputBorder(

                ),
              ),
            ),

            const SizedBox(height: 20,),

            TextField(
              controller: userReg,
              decoration: InputDecoration(
                hintText: 'Username',
                border: OutlineInputBorder(

                ),
              ),
            ),

            const SizedBox(height: 20,),


            TextField(
              obscureText: true,
              controller: pwdReg,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(

                ),
              ),
            ),

            const SizedBox(height: 20,),

            TextField(
              obscureText: false,
              // controller: 
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(

                ),
              ),
            ),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                register(userReg.text.toString(), pwdReg.text.toString());
                // Navigator.push(context, MaterialPageRoute(builder: (context) => IntroPage())); 
              },
              child: Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'Create account', 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}