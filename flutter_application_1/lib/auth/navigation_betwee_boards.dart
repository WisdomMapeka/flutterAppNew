import 'package:flutter/material.dart';
import 'clerk_dashboard.dart';
import 'farmer_dashboard.dart';

class RoleBasedNavigation extends StatelessWidget {
  final String role;

  RoleBasedNavigation({required this.role});

  @override
  Widget build(BuildContext context) {
    return role == 'clerk' ? ClerkDashboard() : FarmerDashboard();
  }
}