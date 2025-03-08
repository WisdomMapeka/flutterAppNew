import 'package:http/http.dart' as http;
import 'dart:convert';
import 'endpoints.dart';

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


Future<void> farmer_submit_data(String farmer_name, String nation_id, String farm_type, String crop, String location ) async {
    final response = await http.post(
        Uri.parse(submit_data_endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
                          "farmer_name": "string",
                          "nation_id": "string",
                          "farm_type": "string",
                          "crop": "string",
                          "location": "string"
                        }),
    );
    
    print(response.statusCode);
    if (response.statusCode == 200) {
        print('User registered successfully');
    } else {
        throw Exception('Failed to register user');
    }
}