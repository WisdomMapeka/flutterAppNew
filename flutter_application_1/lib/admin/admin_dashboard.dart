import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  // Hardcoded data for demonstration
  final List<Map<String, String>> farmerData = [
    {
      'farmer_name': 'John Doe',
      'nation_id': '123456',
      'farm_type': 'Smallholder',
      'crop': 'Maize',
      'location': 'Nairobi',
    },
    {
      'farmer_name': 'Jane Smith',
      'nation_id': '654321',
      'farm_type': 'Commercial',
      'crop': 'Wheat',
      'location': 'Kisumu',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer Dashboard'),
      ),
      body: ListView.builder(
        itemCount: farmerData.length,
        itemBuilder: (context, index) {
          final data = farmerData[index];
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}