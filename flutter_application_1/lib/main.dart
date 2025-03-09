import "package:flutter/material.dart";
import "auth/login_page.dart";
import 'admin/admin_dashboard.dart';
import 'clerks/clerk_dash.dart';
import 'clerks/farmer_submit_data_form.dart';
import 'clerks/list_submited_data.dart';


void main(){
  runApp(const MainContainerApp());
}



class MainContainerApp extends StatelessWidget {
  const MainContainerApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      // home: LoginPage(),
      // home: AdminDashboard(),
       home: ClerkDashboard(),

      routes: {
        '/admin': (context) => AdminDashboard(), // Admin page
        '/clerk': (context) => ClerkDashboard(), // Clerk page
      },
    );
  }
}