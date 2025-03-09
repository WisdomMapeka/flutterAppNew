import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> _isOnline() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult != ConnectivityResult.none;
}
