import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api/endpoints.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboard createState() => _AdminDashboard();
}

class _AdminDashboard extends State<AdminDashboard> {
  bool _showInputForms = false;
  final TextEditingController _input1Controller = TextEditingController();
  final TextEditingController _input2Controller = TextEditingController();
  List<dynamic> _fetchedData = [];


  void _toggleInputForms() {
    setState(() {
      _showInputForms = !_showInputForms;
    });
  }


  

  Future<void> _deleteItem(int id, String deleteUrl) async {
    final response = await http.delete(Uri.parse('$deleteUrl/$id/'));
    print(response.statusCode);

    if (response.statusCode == 204) {
    // Successfully deleted
    setState(() {
      // Remove the item from the list by checking the id
      _fetchedData.removeWhere((item) => item['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item deleted successfully!')),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to delete item!')),
    );
  }
  }



  Future<void> _submitData() async {
    final response = await http.post(
      Uri.parse(save_farmtype_croptype),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'farm_data':{"farm_type": _input1Controller.text} ,
        'crop_type':{"crop_type": _input2Controller.text} ,
      }),
    );

    if (response.statusCode == 201) {
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

 

  Future<void> _fetchData(String endpoint) async {
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      try {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _fetchedData = data;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to decode data!')),
        );
      }
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
              onPressed: () => _fetchData(crop_types),
              child: Text('Crop Types'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _fetchData(admin_add_farmtypes),
              child: Text('Farm Types'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _fetchedData.length,
                itemBuilder: (context, index) {

                  final item = _fetchedData[index];
                  final int id = int.tryParse(item['id'].toString()) ?? 0; 
                  final String type = item.containsKey('crop_type') ? item['crop_type'] : item['farm_type'];
                  final String deleteLink = item.containsKey('crop_type') ? crop_types : admin_add_farmtypes;
       

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: ListTile(
                      title: Text('$type (ID: $id)'),
                      trailing: ElevatedButton(
                          onPressed: () => _deleteItem(id, deleteLink), // Call delete function with the id
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red, // Use backgroundColor instead of primary
                          ),
                          child: Text('Delete', style: TextStyle(color: Colors.white)),
                        )
                    ),
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