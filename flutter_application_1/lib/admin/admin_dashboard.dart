import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/connectivity_check.dart';
import '../models/local_models.dart';
import '../api/connectivity_check.dart';

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
        'farm_data': {"farm_type": _input1Controller.text},
        'crop_type': {"crop_type": _input2Controller.text},
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
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the saved JSON strings from SharedPreferences
    String? data = prefs.getString(endpoint); // This might return null

    if (data != null && data.isNotEmpty) {
      print(data);
      print("data ends========================");

      try {
        // Convert the JSON string into a list of objects
        List<dynamic> fetchedDataJson = json.decode(data);

        // Validate that fetchedDataJson is a list
        if (fetchedDataJson is List) {
          List<dynamic> dataList = [];

          // Determine which model to use based on the endpoint
          if (endpoint == 'crop_types') {
            // Use CropTypeOption model for 'crop_type'
            for (var item in fetchedDataJson) {
              try {
                if (item is Map<String, dynamic>) {
                  dataList.add(CropTypeOption.fromJson(item)); // Convert to CropTypeOption object
                } else {
                  print('Invalid item in crop type data: $item');
                }
              } catch (e) {
                print('Failed to parse crop type item: $item. Error: $e');
              }
            }
          } else if (endpoint == 'farm_types') {
            // Use FarmType model for 'farm_type'
            for (var item in fetchedDataJson) {
              try {
                if (item is Map<String, dynamic>) {
                  dataList.add(FarmType.fromJson(item)); // Convert to FarmType object
                } else {
                  print('Invalid item in farm type data: $item');
                }
              } catch (e) {
                print('Failed to parse farm type item: $item. Error: $e');
              }
            }
          }

          // Update the state with the fetched data
          setState(() {
            _fetchedData = dataList; // Update the list with the correct model
          });
        } else {
          throw Exception('Invalid data format: Expected a list of JSON objects');
        }
      } catch (e) {
        // If JSON decoding fails, show a snack bar error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to decode data: $e')),
        );
      }
    } else {
      // Handle the case when there is no data or data is empty
      print('No data found for $endpoint');

      // Optionally, you can assign an empty list or some default behavior
      List<dynamic> emptyList = [];

      // Update state with empty list or show a message
      setState(() {
        _fetchedData = emptyList;
      });

      // Optionally, show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No data found for $endpoint.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print("fetched data--------------------------------------------");
    print(_fetchedData);
    print("fetched data--------------------------------------------");
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
              onPressed: () => _fetchData("crop_types"),
              child: Text('Crop Types'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _fetchData("farm_types"),
              child: Text('Farm Types'),
            ),
            SizedBox(height: 20),
            // Sync Data button
            ElevatedButton(
              onPressed: () {
                syncData(); // Sync the fetched data
              },
              child: Text('Sync Data'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _fetchedData.length,
                itemBuilder: (context, index) {
                  // Get the item from the list (which can be either a FarmType or CropTypeOption)
                  final item = _fetchedData[index];

                  // Declare variables for id, type, and deleteLink
                  int id = 0;
                  String type = '';
                  String deleteLink = '';

                  // Check if the item is of type FarmType or CropTypeOption
                  if (item is FarmType) {
                    // Access properties for FarmType
                    id = item.id; // ID for FarmType
                    type = item.farmType; // Farm type name
                    deleteLink = admin_add_farmtypes; // Link for FarmType
                  } else if (item is CropTypeOption) {
                    // Access properties for CropTypeOption
                    id = item.id; // ID for CropTypeOption
                    type = item.cropType; // Crop type name
                    deleteLink = crop_types; // Link for CropTypeOption
                  }

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: ListTile(
                      title: Text('$type (ID: $id)'),
                      trailing: ElevatedButton(
                        onPressed: () => _deleteItem(id, deleteLink),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Text('Delete', style: TextStyle(color: Colors.white)),
                      ),
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
