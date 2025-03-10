import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/local_models.dart';
import '../api/connectivity_check.dart';

class FarmerSubmittedData extends StatefulWidget {
  @override
  _FarmerSubmittedDataState createState() => _FarmerSubmittedDataState();
}

class _FarmerSubmittedDataState extends State<FarmerSubmittedData> {
  // List to store fetched farmer data
  List<FarmerData> _farmerData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Fetch the data from local storage (SharedPreferences) when the screen loads
    _fetchFarmerData();
  }

  // Function to fetch farmer data from SharedPreferences
  Future<void> _fetchFarmerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the saved JSON string from SharedPreferences
    String? data = prefs.getString('farmer_data'); // This might return null

    if (data != null && data.isNotEmpty) {
      try {
        // Convert the JSON string into a list of objects
        List<dynamic> farmerDataJson = json.decode(data);

        // Validate that the farmerDataJson is a list
        if (farmerDataJson is List) {
          List<FarmerData> farmerDataList = [];
          for (var item in farmerDataJson) {
            try {
              if (item is Map<String, dynamic>) {
                // Add the decoded FarmerData object to the list
                farmerDataList.add(FarmerData.fromJson(item));
              } else {
                print('Invalid item in farmerDataJson: $item');
              }
            } catch (e) {
              print('Failed to parse item: $item. Error: $e');
            }
          }

          setState(() {
            _farmerData = farmerDataList;
            _isLoading = false; // Data loaded, stop loading indicator
          });
        } else {
          throw Exception('Invalid data format: Expected a list of JSON objects');
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching data: $e')),
        );
      }
    } else {
      // Handle the case when there is no data or data is empty
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No farmer data found')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer Submitted Data'),
      ),
      body: Column(
        children: [
          _isLoading
              ? Center(child: CircularProgressIndicator()) // Show loading indicator
              : Expanded(
                  child: ListView.builder(
                    itemCount: _farmerData.length,
                    itemBuilder: (context, index) {
                      final data = _farmerData[index];
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(data.farmerName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nation ID: ${data.nationId}'),
                              Text('Farm Type: ${data.farmType}'),
                              Text('Crop: ${data.crop}'),
                              Text('Location: ${data.location}'),
                              Text('Crop Type: ${data.cropType}'), // Display crop_type
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
          SizedBox(height: 20),
          // Button to navigate back to the home page
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/'); // Navigate back to the home page using the named route
            },
            child: Text('Back to Home'),
          ),
          SizedBox(height: 20),
          // Button to sync the data
          ElevatedButton(
            onPressed: () {
              syncData(); // Call the syncData function when pressed, passing the _farmerData
            },
            child: Text('Sync Data'),
          ),
        ],
      ),
    );
  }
}
