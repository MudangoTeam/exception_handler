import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';

Future<String> getNetworkType() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  final networkInfo = NetworkInfo();
  final wifiIPv4Addr = await networkInfo.getWifiIP();

  if (connectivityResult == ConnectivityResult.mobile) {
    return '''
        Connected by: Mobile data <br>
        IP: $wifiIPv4Addr
      ''';
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return '''
        Connected by: Wi-Fi <br>
        IP: $wifiIPv4Addr
      ''';
  } else {
    return 'Not internet connection';
  }
}
