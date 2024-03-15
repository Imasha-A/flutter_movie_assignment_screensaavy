import 'package:connectivity_plus/connectivity_plus.dart';

//class to handle netowork connectivty
Future<bool> checkInternetConnectivity() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;
}
