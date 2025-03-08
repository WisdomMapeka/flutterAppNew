import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api/endpoints.dart';

// Replace with your actual login endpoint
// const String loginEndpoint = login_endpoint;

Future<Map<String, dynamic>> login(String username, String password) async {
  final response = await http.post(
    Uri.parse(login_endpoint),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'username': username, 'password': password}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final role = data['role'];
    return {
      'success': true,
      'role': role,
      'token': data['token'],  // Assuming you return a token from your API
    };
  } else {
    final errorData = jsonDecode(response.body);
    return {
      'success': false,
      'error': errorData['error'] ?? 'Failed to login',
    };
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _message = '';

  Future<void> handleLogin() async {
    final result = await login(_usernameController.text, _passwordController.text);
    
    if (result['success']) {
      // Navigate based on role
      final role = result['role'];
      if (role == 'admin') {
        // Navigate to admin page
        // Navigator.pushNamed(context, '/admin');
        print("admin");
      } else {
        // Navigate to clerk page
        // Navigator.pushNamed(context, '/clerk');
        print("cleck");
      }
      setState(() {
        _message = 'Login successful!';
      });
    } else {
      // Display error message
      setState(() {
        _message = result['error'];
      });
      // Optionally show a Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['error'])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleLogin,
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            Text(_message, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}