import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api/endpoints.dart';
import '../api/backend_call.dart';

class FarmerDataSubmition extends StatefulWidget {
  @override
  _ClerkDashboardState createState() => _ClerkDashboardState();
}

class _ClerkDashboardState extends State<FarmerDataSubmition> {
  final _formKey = GlobalKey<FormState>();
  final _farmerNameController = TextEditingController();
  final _nationIdController = TextEditingController();
  final _cropController = TextEditingController();
  final _locationController = TextEditingController();

  // Dropdown values for farm_type and crop_type
  int? _selectedFarmTypeId;
  int? _selectedCropTypeId;

  // Lists to store fetched data
  List<Map<String, dynamic>> _farmTypes = [];
  List<Map<String, dynamic>> _cropTypes = [];

  // Track loading state
  bool _isLoadingFarmTypes = false;
  bool _isLoadingCropTypes = false;

  @override
  void initState() {
    super.initState();
    // Fetch farm types and crop types when the widget is initialized
    _fetchFarmTypes();
    _fetchCropTypes();
  }

  // Fetch farm types from the API
  Future<void> _fetchFarmTypes() async {
    setState(() {
      _isLoadingFarmTypes = true;
    });

    try {
      final response = await http.get(Uri.parse(admin_add_farmtypes));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _farmTypes = data.map((item) => {
            'id': item['id'] ?? 0, // Use 'id' from the API response
            'name': item['farm_type'] ?? 'Unknown', // Use 'farm_type' from the API response
          }).toList();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch farm types')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching farm types: $e')),
      );
    } finally {
      setState(() {
        _isLoadingFarmTypes = false;
      });
    }
  }

  // Fetch crop types from the API
  Future<void> _fetchCropTypes() async {
    setState(() {
      _isLoadingCropTypes = true;
    });

    try {
      final response = await http.get(Uri.parse(crop_types));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _cropTypes = data.map((item) => {
            'id': item['id'] ?? 0, // Use 'id' from the API response
            'name': item['crop_type'] ?? 'Unknown', // Use 'crop_type' from the API response
          }).toList();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch crop types')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching crop types: $e')),
      );
    } finally {
      setState(() {
        _isLoadingCropTypes = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clerk Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _farmerNameController,
                decoration: InputDecoration(labelText: 'Farmer Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the farmer\'s name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nationIdController,
                decoration: InputDecoration(labelText: 'Nation ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the nation ID';
                  }
                  return null;
                },
              ),
              // Farm Type Dropdown
              _isLoadingFarmTypes
                  ? CircularProgressIndicator()
                  : DropdownButtonFormField<int>(
                      value: _selectedFarmTypeId,
                      decoration: InputDecoration(labelText: 'Farm Type'),
                      items: _farmTypes.map((Map<String, dynamic> farmType) {
                        return DropdownMenuItem<int>(
                          value: farmType['id'],
                          child: Text(farmType['name']),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedFarmTypeId = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a farm type';
                        }
                        return null;
                      },
                    ),
              // Crop Type Dropdown
              _isLoadingCropTypes
                  ? CircularProgressIndicator()
                  : DropdownButtonFormField<int>(
                      value: _selectedCropTypeId,
                      decoration: InputDecoration(labelText: 'Crop Type'),
                      items: _cropTypes.map((Map<String, dynamic> cropType) {
                        return DropdownMenuItem<int>(
                          value: cropType['id'],
                          child: Text(cropType['name']),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedCropTypeId = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a crop type';
                        }
                        return null;
                      },
                    ),
              // Crop Text Input
              TextFormField(
                controller: _cropController,
                decoration: InputDecoration(labelText: 'Crop'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the crop';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Submit the form data
                    _submitForm();
                  }
                },
                child: Text('Submit'),
              ),
              SizedBox(height: 20),
              // Button to navigate back to the home page
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/'); // Navigate back to the home page using the named route
                },
                child: Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    final farmerData = {
      'farmer_name': _farmerNameController.text,
      'nation_id': _nationIdController.text,
      'farm_type': _selectedFarmTypeId,
      'crop_type': _selectedCropTypeId,
      'crop': _cropController.text,
      'location': _locationController.text,
    };

    // TODO: Call API to submit data or save locally
    print('Farmer Data: $farmerData');
    farmer_submit_data(
      _farmerNameController.text,
      _nationIdController.text,
      _selectedFarmTypeId!,
      _selectedCropTypeId!,
      _cropController.text,
      _locationController.text,
    );

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data submitted successfully')),
    );

    // Clear the form
    _formKey.currentState!.reset();
    setState(() {
      _selectedFarmTypeId = null;
      _selectedCropTypeId = null;
    });
  }
}
