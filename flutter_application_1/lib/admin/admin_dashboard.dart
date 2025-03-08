import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboard createState() => _AdminDashboard();
}

class _AdminDashboard extends State<AdminDashboard> {
  bool _showInputForms = false;
  final TextEditingController _input1Controller = TextEditingController();
  final TextEditingController _input2Controller = TextEditingController();
  List<String> _fetchedData = [];

  // Replace with your actual endpoint
  final String submitEndpoint = 'http://yourapi.com/submit';
  final String fetchEndpoint = 'http://yourapi.com/fetch';

  void _toggleInputForms() {
    setState(() {
      _showInputForms = !_showInputForms;
    });
  }

  Future<void> _submitData() async {
    final response = await http.post(
      Uri.parse(submitEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'input1': _input1Controller.text,
        'input2': _input2Controller.text,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data submitted successfully!')),
      );
      _input1Controller.clear();
      _input2Controller.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Submission failed!')),
      );
    }
  }

  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse(fetchEndpoint));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _fetchedData = data.map((item) => item.toString()).toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch data!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crop And Farm Types Configurations')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _toggleInputForms,
              child: Text('Add Crop Type And Farm Types'),
            ),
            if (_showInputForms) ...[
              TextField(
                controller: _input1Controller,
                decoration: InputDecoration(labelText: 'Add Farm Type'),
              ),
              TextField(
                controller: _input2Controller,
                decoration: InputDecoration(labelText: 'Add Crop Type'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitData,
                child: Text('Submit Data'),
              ),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchData,
              child: Text('Display Saved Crop And Farm Types'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _fetchedData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_fetchedData[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}