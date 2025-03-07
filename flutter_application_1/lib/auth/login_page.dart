import "package:flutter/material.dart";
import '../components/auth/usernamePasswordInput.dart';
import '../components/auth/signInbuton.dart';


class LoginUIPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginUIPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 237, 216),
      body: SafeArea(child: Center(
        child: Column(
            children: [
              SizedBox(height: 50,),
              // Logo section
              Icon(
                Icons.lock,
                size: 100,
              ),
              // introduction text
              SizedBox(height: 50,),
              Text("Welcome Farmer, Please Login Below",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                    ),
              ),
            
              // login form username
              SizedBox(height: 30,),
              UsernamePasswordInputForm(controller: usernameController, hinttext: "Username", obscureText: false,),

              // login form password
              SizedBox(height: 30,),
              UsernamePasswordInputForm(controller: passwordController, hinttext: "Username", obscureText: true,),
             
              

              // button [with login text]
              SizedBox(height: 30,),
              SigninButton(),


            ],
          )
        )
      ));
  }
}