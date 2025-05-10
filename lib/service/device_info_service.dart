import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future<DeviceInfo?> getDeviceInfo() async {
    if (Platform.isAndroid) {
      final info = await deviceInfoPlugin.androidInfo;
      return DeviceInfo(
          deviceName: info.device,
          deviceModel: info.model,
          os: 'Android',
          osVersion: info.version.release,
          platform: 'app');
    } else if (Platform.isIOS) {
      final info = await deviceInfoPlugin.iosInfo;
      return DeviceInfo(
          deviceName: info.name,
          deviceModel: info.model,
          os: 'iOS',
          osVersion: info.systemVersion,
          platform: 'app');
    } else if (Platform.isMacOS) {
      final info = await deviceInfoPlugin.macOsInfo;
      return DeviceInfo(
          deviceName: info.computerName,
          deviceModel: info.model,
          os: 'macOS',
          osVersion: info.osRelease,
          platform: 'web');
    } else if (Platform.isWindows) {
      final info = await deviceInfoPlugin.windowsInfo;
      return DeviceInfo(
          deviceName: info.computerName,
          deviceModel: "unknown windows model",
          os: 'Windows',
          osVersion: info.buildNumber.toString(),
          platform: 'web');
    } else if (Platform.isLinux) {
      final info = await deviceInfoPlugin.linuxInfo;
      return DeviceInfo(
          deviceName: info.name,
          deviceModel: "unknown linux model",
          os: 'Linux',
          osVersion: info.version.toString(),
          platform: 'web');
    }

    return null;
  }
}

class DeviceInfo {
  final String deviceName;
  final String deviceModel;
  final String os;
  final String osVersion;
  final String platform;

  DeviceInfo({
    required this.deviceName,
    required this.deviceModel,
    required this.os,
    required this.osVersion,
    required this.platform,
  });
}
