import 'package:flutter/material.dart';

class ClerkDashboard extends StatefulWidget {
  @override
  _ClerkDashboardState createState() => _ClerkDashboardState();
}

class _ClerkDashboardState extends State<ClerkDashboard> {
  final _formKey = GlobalKey<FormState>();
  final _farmerNameController = TextEditingController();
  final _nationIdController = TextEditingController();
  final _farmTypeController = TextEditingController();
  final _cropController = TextEditingController();
  final _locationController = TextEditingController();

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
              TextFormField(
                controller: _farmTypeController,
                decoration: InputDecoration(labelText: 'Farm Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the farm type';
                  }
                  return null;
                },
              ),
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
      'farm_type': _farmTypeController.text,
      'crop': _cropController.text,
      'location': _locationController.text,
    };

    // TODO: Call API to submit data or save locally
    print('Farmer Data: $farmerData');

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data submitted successfully')),
    );

    // Clear the form
    _formKey.currentState!.reset();
  }
}