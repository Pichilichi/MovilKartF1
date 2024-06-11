import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kartf1/pages/intro_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

}

TextEditingController userController = TextEditingController();
TextEditingController pwdController = TextEditingController();

void login(String user, password) async{
  try{
    Response response = await post(Uri.parse('https://pacou.pythonanywhere.com/login'),
      body: {
        'username': user,
        'password': password,
      }
    );
    if(response.statusCode == 200){
      print('account logged');
    }else{
      print('failed');
    }
  }catch(e){
    print(e.toString());
  }
}

class _LoginPageState extends State<LoginPage>{
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
              controller: pwdController,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(

                ),
              ),
            ),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                login(userController.text.toString(), pwdController.text.toString());
                Navigator.push(context, MaterialPageRoute(builder: (context) => IntroPage()));
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
            )
          ],
        ),
      ),
    );
  }
  
}