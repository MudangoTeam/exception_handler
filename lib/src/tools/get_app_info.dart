import 'package:package_info_plus/package_info_plus.dart';

Future<String> getAppInfo(String environment) async {
  final packageInfo = await PackageInfo.fromPlatform();
  return '''
    appEnvironment: $environment<br>
    appName: ${packageInfo.appName}<br>
    packageName: ${packageInfo.packageName}<br>
    version: ${packageInfo.version}<br>
    buildNumber: ${packageInfo.buildNumber}<br>
    ''';
}
