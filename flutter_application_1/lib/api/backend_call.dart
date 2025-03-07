import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> login(String username, String password) async {
    final response = await http.post(
        Uri.parse('http://<your-django-server>/api/login/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final role = data['role'];
        // Navigate based on role
    } else {
        throw Exception('Failed to login');
    }
}

Future<void> submitData(Map<String, dynamic> data) async {
    final response = await http.post(
        Uri.parse('http://<your-django-server>/api/submit-data/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
        throw Exception('Failed to submit data');
    }
}



Future<void> syncData(List<Map<String, dynamic>> data) async {
    final response = await http.post(
        Uri.parse('http://<your-django-server>/api/sync-data/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
        throw Exception('Failed to sync data');
    }
}




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