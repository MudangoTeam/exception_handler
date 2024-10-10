import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<String> getDeviceInfo() async {
  final deviceInfo = DeviceInfoPlugin();
  final system = Platform.isIOS ? 'iOS' : 'Android';

  if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    return '''
      name: ${iosInfo.name}<br>
      systemName: ${iosInfo.systemName}<br>
      systemVersion: ${iosInfo.systemVersion}<br>
      model: ${iosInfo.model}<br>
      localizedModel: ${iosInfo.localizedModel}<br>
      identifierForVendor: ${iosInfo.identifierForVendor}<br>
      isPhysicalDevice: ${iosInfo.isPhysicalDevice}<br>
      utsname.sysname: ${iosInfo.utsname.sysname}<br>
      utsname.nodename: ${iosInfo.utsname.nodename}<br>
      utsname.release: ${iosInfo.utsname.release}<br>
      utsname.version: ${iosInfo.utsname.version}<br>
      utsname.machine: ${iosInfo.utsname.machine}<br>
      ''';
  } else {
    final androidInfo = await deviceInfo.androidInfo;
    return '''
      systemName: $system<br>
      androidId: ${androidInfo.id}<br>
      board: ${androidInfo.board}<br>
      bootloader: ${androidInfo.bootloader}<br>
      brand: ${androidInfo.brand}<br>
      device: ${androidInfo.device}<br>
      display: ${androidInfo.display}<br>
      fingerprint: ${androidInfo.fingerprint}<br>
      hardware: ${androidInfo.hardware}<br>
      host: ${androidInfo.host}<br>
      id: ${androidInfo.id}<br>
      manufacturer: ${androidInfo.manufacturer}<br>
      model: ${androidInfo.model}<br>
      product: ${androidInfo.product}<br>
      supported32BitAbis: ${androidInfo.supported32BitAbis}<br>
      supported64BitAbis: ${androidInfo.supported64BitAbis}<br>
      supportedAbis: ${androidInfo.supportedAbis}<br>
      tags: ${androidInfo.tags}<br>
      type: ${androidInfo.type}<br>
      isPhysicalDevice: ${androidInfo.isPhysicalDevice}<br>
      versionSdkInt: ${androidInfo.version.sdkInt}<br>
      versionRelease: ${androidInfo.version.release}<br>
      versionPreviewSdkInt: ${androidInfo.version.previewSdkInt}<br>
      versionIncremental: ${androidInfo.version.incremental}<br>
      versionCodename: ${androidInfo.version.codename}<br>
      versionBaseOS: ${androidInfo.version.baseOS}<br>
      ''';
  }
}
