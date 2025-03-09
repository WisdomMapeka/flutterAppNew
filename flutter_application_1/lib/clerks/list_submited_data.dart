import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FarmerSubmittedData extends StatefulWidget {
  @override
  _FarmerSubmittedDataState createState() => _FarmerSubmittedDataState();
}

class _FarmerSubmittedDataState extends State<FarmerSubmittedData> {
  // List to store fetched farmer data
  List<Map<String, dynamic>> _farmerData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Fetch the data from the API when the screen loads
    _fetchFarmerData();
  }

  // Function to fetch farmer data from the API
  Future<void> _fetchFarmerData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8000/api/farmer-data/'));
      
      if (response.statusCode == 200) {
        // If the request was successful, parse the JSON data
        final List<dynamic> data = jsonDecode(response.body);

        setState(() {
          _farmerData = data.map((item) => {
            'farmer_name': item['farmer_name'],
            'nation_id': item['nation_id'],
            'farm_type': item['farm_type'].toString(), // Ensure farm_type is a string
            'crop': item['crop'],
            'location': item['location'],
            'crop_type': item['crop_type'].toString(), // Include crop_type
          }).toList();
          _isLoading = false; // Data loaded, stop loading indicator
        });
      } else {
        // If the response is not successful, show an error message
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load farmer data')),
        );
      }
    } catch (e) {
      // Handle any errors during the HTTP request
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : ListView.builder(
              itemCount: _farmerData.length,
              itemBuilder: (context, index) {
                final data = _farmerData[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(data['farmer_name']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nation ID: ${data['nation_id']}'),
                        Text('Farm Type: ${data['farm_type']}'),
                        Text('Crop: ${data['crop']}'),
                        Text('Location: ${data['location']}'),
                        Text('Crop Type: ${data['crop_type']}'), // Display crop_type
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
