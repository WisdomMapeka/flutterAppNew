import './farmer_submit_data_form.dart';
import '../clerks/list_submited_data.dart';
import 'package:flutter/material.dart';

class ClerkDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer Data Management'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Button to navigate to FarmerSubmittedData
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FarmerSubmittedData()),
                );
              },
              child: Text('View Submitted Farmer Data'),
            ),
            SizedBox(height: 20),
            // Button to navigate to FarmerDataSubmition
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FarmerDataSubmition()),
                );
              },
              child: Text('Submit New Farmer Data'),
            ),
            
          ],
        ),
      ),
    );
  }
}
