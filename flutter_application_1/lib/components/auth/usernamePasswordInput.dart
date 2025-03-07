import 'package:flutter/material.dart';

class UsernamePasswordInputForm extends StatelessWidget{
  final controller;
  final bool obscureText;
  final String hinttext;

  const UsernamePasswordInputForm({super.key, this.controller, required this.obscureText, required this.hinttext});

  @override
  Widget build(BuildContext context) {
      return   Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: hinttext,
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade100),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400)
                          ),
                          fillColor: const Color.fromARGB(255, 255, 254, 254),
                          filled: true,
                        ),

                        obscureText: obscureText,
                        controller: controller,
                      ),
                    );
              
  }
}