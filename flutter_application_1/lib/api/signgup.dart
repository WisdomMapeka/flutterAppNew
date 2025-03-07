import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> signup(String username, String password, String email, String role) async {
    final response = await http.post(
        Uri.parse('http://<your-django-server>/api/signup/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
            'user': {
                'username': username,
                'password': password,
                'email': email,
            },
            'role': role,
        }),
    );

    if (response.statusCode == 201) {
        print('User registered successfully');
    } else {
        throw Exception('Failed to register user');
    }
}