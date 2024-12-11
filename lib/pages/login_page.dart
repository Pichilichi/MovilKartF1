import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kartf1/pages/intro_page.dart';

import '../django/urls.dart';


// LOGIN AND REGISTER CLASSES
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

// LOGIN PAGE
class _LoginPageState extends State<LoginPage>{

  TextEditingController userController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  Urls u = Urls();

  // Calls the api and tries to log in the user we sent
  // returns a message if it fails
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
        List l = data.values.toList();
        Navigator.push(context, MaterialPageRoute(builder: (context) => IntroPage()));
        u.setUser(l[1],l[0]);
      }else{
        showDialog(
          context: context, 
          builder: (context) => const AlertDialog(
            title: Text('Something went wrong...'),
            content: Text('Check your credentials'),
          ),
        );
      }
    }catch(e){
      print(e.toString());
    }
  }

  // Login build
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Welcome back!"),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold, 
          fontSize: 36, 
          color: Colors.black,
        ),
        toolbarHeight: 40,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, 
        scrolledUnderElevation: 0.0, 
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
              decoration: const InputDecoration(
                hintText: 'username',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20,),

            TextField(
              obscureText: true,
              controller: pwdController,
              decoration: const InputDecoration(
                hintText: 'password',
                border: OutlineInputBorder(),
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

// REGISTER PAGE
class _RegisterPageState extends State<RegisterPage> {

  // Calls the api and tries to register the new user
  // if something is not okay, show a message
  register(String user, password, firstname, email) async{

    if(user.isEmpty || password.isEmpty || firstname.isEmpty || email.isEmpty){
      showDialog(
        context: context, 
        builder: (context) => const AlertDialog(
          title: Text('Error'),
          content: Text('Fields cannot be blank'),
        ),
      );
    } else {
      try{
        Response response = await post(
          Uri.parse('https://pacou.pythonanywhere.com/register'),
          body: {
            'username': user,
            'password': password,
            'first_name': firstname,
            'email': email,
          }
        );
        if(response.statusCode == 201){
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
          showDialog(
            context: context, 
            builder: (context) => const AlertDialog(
              title: Text('Account created!'),
              content: Text('Log in with your new account'),
            ),
          );
        }else{
          showDialog(
            context: context, 
            builder: (context) => const AlertDialog(
              title: Text('Something went wrong...'),
              content: Text('Check your credentials'),
            ),
          );
        }
      }catch(e){
        print(e.toString());
      }
    }
  }

  TextEditingController userReg = TextEditingController();
  TextEditingController firstReg = TextEditingController();
  TextEditingController emailReg = TextEditingController();
  TextEditingController pwdReg = TextEditingController();

  // Register build
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Nice to meet you!"),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold, 
          fontSize: 36, 
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, 
        scrolledUnderElevation: 0.0, 
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
            const Text("Let's register you first! "),

            const SizedBox(height: 50),

            TextField(
              obscureText: false,
              controller: firstReg,
              decoration: const InputDecoration(
                hintText: 'Firstname',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20,),

            TextField(
              controller: userReg,
              decoration: const InputDecoration(
                hintText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20,),

            TextField(
              obscureText: true,
              controller: pwdReg,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20,),

            TextField(
              obscureText: false,
              controller: emailReg, 
              decoration: const InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20,),

            GestureDetector(
              onTap: () {
                register(userReg.text.toString(), pwdReg.text.toString(), firstReg.text.toString(), emailReg.text.toString());
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