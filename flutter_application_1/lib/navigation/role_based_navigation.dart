import 'package:flutter/material.dart';
import '../clerks/clerk_dash.dart';
import '../admin/admin_dashboard.dart';

class RoleBasedNavigation extends StatelessWidget {
  final String role;

  RoleBasedNavigation({required this.role});

  @override
  Widget build(BuildContext context) {
    return role == 'clerk' ? ClerkDashboard() : AdminDashboard();
  }
}