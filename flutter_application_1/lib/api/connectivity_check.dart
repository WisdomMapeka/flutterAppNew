import 'package:connectivity_plus/connectivity_plus.dart';
import "package:flutter/material.dart";
import '../auth/login_page.dart';
import '../admin/admin_dashboard.dart';
import '../clerks/clerk_dash.dart';
import '../clerks/farmer_submit_data_form.dart';
import '../clerks/list_submited_data.dart';
import '../api/connectivity_check.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import '../models/local_models.dart';
// import 'dart:io';

// Future<bool> isDeviceOnline() async {
//   try {
//     final result = await InternetAddress.lookup('google.com');
//     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//       return true;
//     }
//   } on SocketException catch (_) {
//     return false;
//   }
//   return false;
// }


Future<bool> isDeviceOnline() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult != ConnectivityResult.none;
}



Future<void> syncData() async {
  print("Syncing data...");

  // Define the endpoints
  final farmerDataUrl = Uri.parse('http://localhost:8000/api/farmer-data/');
  final farmTypesUrl = Uri.parse('http://localhost:8000/api/farm-types/');
  final cropTypesUrl = Uri.parse('http://localhost:8000/api/croptype-options/');

  try {
    // Fetch farmer data
    final farmerDataResponse = await http.get(farmerDataUrl);
    final farmTypesResponse = await http.get(farmTypesUrl);
    final cropTypesResponse = await http.get(cropTypesUrl);

    if (farmerDataResponse.statusCode == 200 &&
        farmTypesResponse.statusCode == 200 &&
        cropTypesResponse.statusCode == 200) {
      // Parse the JSON data into models
      List<dynamic> farmerDataJson = json.decode(farmerDataResponse.body);
      List<dynamic> farmTypesJson = json.decode(farmTypesResponse.body);
      List<dynamic> cropTypesJson = json.decode(cropTypesResponse.body);

      List<FarmerData> farmerDataList =
          farmerDataJson.map((e) => FarmerData.fromJson(e)).toList();
      List<FarmType> farmTypeList =
          farmTypesJson.map((e) => FarmType.fromJson(e)).toList();
      List<CropTypeOption> cropTypeOptionList =
          cropTypesJson.map((e) => CropTypeOption.fromJson(e)).toList();

      // Save the data locally
      await saveDataLocally(farmerDataList, farmTypeList, cropTypeOptionList);

      print("Data synced successfully!");
    } else {
      print("Failed to load data from one or more endpoints");
    }
  } catch (e) {
    print("Error syncing data: $e");
  }
}

// Function to save data locally using SharedPreferences (or any other local storage solution)
Future<void> saveDataLocally(
    List<FarmerData> farmerData,
    List<FarmType> farmTypes,
    List<CropTypeOption> cropTypes) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Convert lists to JSON strings to store in SharedPreferences
  prefs.setString('farmer_data', json.encode(farmerData.map((e) => e.toJson()).toList()));
  prefs.setString('farm_types', json.encode(farmTypes.map((e) => e.toJson()).toList()));
  prefs.setString('crop_types', json.encode(cropTypes.map((e) => e.toJson()).toList()));
  
  print("Data saved locally!");
}



// try to retreave data
Future<void> retrieveData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? farmerDataString = prefs.getString('farmer_data');
  String? farmTypesString = prefs.getString('farm_types');
  String? cropTypesString = prefs.getString('crop_types');

  if (farmerDataString != null) {
    // Convert the JSON strings back to a list of objects
    List<dynamic> farmerDataJson = json.decode(farmerDataString);
    List<FarmerData> farmerDataList = farmerDataJson.map((e) => FarmerData.fromJson(e)).toList();
    print(farmerDataList);
  }

  if (farmTypesString != null) {
    List<dynamic> farmTypesJson = json.decode(farmTypesString);
    List<FarmType> farmTypesList = farmTypesJson.map((e) => FarmType.fromJson(e)).toList();
    print(farmTypesList);
  }

  if (cropTypesString != null) {
    List<dynamic> cropTypesJson = json.decode(cropTypesString);
    List<CropTypeOption> cropTypesList = cropTypesJson.map((e) => CropTypeOption.fromJson(e)).toList();
    print(cropTypesList);
  }
}
