import 'package:connectivity_plus/connectivity_plus.dart';

Future<String> getNetworkType() async {
  final connectivityResult = await Connectivity().checkConnectivity();

  if (connectivityResult == ConnectivityResult.mobile) {
    return 'Connected by mobile data';
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return 'Connected by Wi-Fi';
  } else {
    return 'Not internet connection';
  }
}
