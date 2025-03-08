import "package:flutter/material.dart";
import "auth/login_page.dart";
import 'navigation/role_based_navigation.dart';

void main(){
  runApp(const MainContainerApp());
}



class MainContainerApp extends StatelessWidget {
  const MainContainerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      // home: RoleBasedNavigation(role: 'clerk')
      home: LoginUIPage()
    );
  }
}