import "package:flutter/material.dart";
import "auth/login_page.dart";
import 'admin/admin_dashboard.dart';
import 'clerks/clerk_dash.dart';
import 'clerks/farmer_submit_data_form.dart';
import 'clerks/list_submited_data.dart';
import 'api/connectivity_check.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  runApp(const MainContainerApp());
}

class MainContainerApp extends StatefulWidget {
  const MainContainerApp({super.key});

  @override
  _MainContainerAppState createState() => _MainContainerAppState();
}

class _MainContainerAppState extends State<MainContainerApp> {
  @override
  void initState() {
    super.initState();
    _checkConnectivityAndSync();
  }

  // Check connectivity and sync data
  Future<void> _checkConnectivityAndSync() async {
    bool isOnline = await isDeviceOnline();
    if (isOnline) {
      // Sync data once online
      await syncData();
      print("Device is online. Data synced.");
      await retrieveData();
    } else {
      print("Device is offline.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      // home: AdminDashboard(),
      // home: ClerkDashboard(),
      routes: {
        '/admin': (context) => AdminDashboard(), // Admin page
        '/clerk': (context) => ClerkDashboard(), // Clerk page
      },
    );
  }
}
