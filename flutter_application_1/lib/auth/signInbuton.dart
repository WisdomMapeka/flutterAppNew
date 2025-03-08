import 'package:flutter/material.dart';
import '../navigation/role_based_navigation.dart';

class SigninButton extends StatelessWidget {
  final requestResponseRole;
  const SigninButton({super.key, this.requestResponseRole});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Center(

        child: ElevatedButton(
          onPressed: () {
           RoleBasedNavigation(role: requestResponseRole);
          },

            child: Text(
              "Log In",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
        ),
      ),
    );
    
  }
}