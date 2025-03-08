import 'package:flutter/material.dart';
import '../clerks/admin_dash.dart';
import '../farmers/farmers_dashboard.dart';

class RoleBasedNavigation extends StatelessWidget {
  final String role;

  RoleBasedNavigation({required this.role});

  @override
  Widget build(BuildContext context) {
    return role == 'clerk' ? ClerkDashboard() : FarmerDashboard();
  }
}