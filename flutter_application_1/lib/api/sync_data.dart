// THIS IS AN EXAMPLE OF HOW THE FULL CODE OF SHARED DATA  WORK, IMPLEMENT IT ON ALL CASES THAT REQUIRE API DATA

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class FarmerSubmittedData extends StatefulWidget {
  @override
  _FarmerSubmittedDataState createState() => _FarmerSubmittedDataState();
}

class _FarmerSubmittedDataState extends State<FarmerSubmittedData> {
  List<Map<String, dynamic>> _farmerData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFarmerData();
  }

  Future<bool> _isOnline() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> _fetchFarmerData() async {
    setState(() {
      _isLoading = true;
    });

    if (await _isOnline()) {
      try {
        final response = await http.get(Uri.parse('http://localhost:8000/api/farmer-data/'));
        if (response.statusCode == 200) {
          final List<dynamic> data = jsonDecode(response.body);
          await _saveFarmerDataLocally(data);

          setState(() {
            _farmerData = data.map((item) => {
              'farmer_name': item['farmer_name'],
              'nation_id': item['nation_id'],
              'farm_type': item['farm_type'].toString(),
              'crop': item['crop'],
              'location': item['location'],
              'crop_type': item['crop_type'].toString(),
            }).toList();
            _isLoading = false;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to load farmer data')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching data: $e')),
        );
      }
    } else {
      final localData = await _getFarmerDataLocally();
      if (localData.isNotEmpty) {
        setState(() {
          _farmerData = localData;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No data available offline')),
        );
      }
    }
  }

  Future<void> _saveFarmerDataLocally(List<dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = jsonEncode(data);
    await prefs.setString('farmer_data', jsonData);
  }

  Future<List<Map<String, dynamic>>> _getFarmerDataLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('farmer_data');
    if (jsonData != null) {
      List<dynamic> dataList = jsonDecode(jsonData);
      return dataList.map((item) => Map<String, dynamic>.from(item)).toList();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
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
                        Text('Crop Type: ${data['crop_type']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

