import "package:flutter/material.dart";
import "auth/login_page.dart";

void main(){
  runApp(const MainContainerApp());
}



class MainContainerApp extends StatelessWidget {
  const MainContainerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: LoginUIPage()
    );
  }
}


// make this below code the main code in this main file, as it allows role base selection of boards

// import 'package:flutter/material.dart';
// import 'role_based_navigation.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: RoleBasedNavigation(role: 'clerk'), // Change role to 'farmer' for Farmer Dashboard
//     );
//   }
// }