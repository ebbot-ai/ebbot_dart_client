import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

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

class PlatformDeviceInfo {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future<DeviceInfo?> getDeviceInfo() async {
    try {
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
            platform: 'app');
      } else if (Platform.isWindows) {
        final info = await deviceInfoPlugin.windowsInfo;
        return DeviceInfo(
            deviceName: info.computerName,
            deviceModel: "unknown windows model",
            os: 'Windows',
            osVersion: info.buildNumber.toString(),
            platform: 'app');
      } else if (Platform.isLinux) {
        final info = await deviceInfoPlugin.linuxInfo;
        return DeviceInfo(
            deviceName: info.name,
            deviceModel: "unknown linux model",
            os: 'Linux',
            osVersion: info.version.toString(),
            platform: 'app');
      }
    } catch (e) {
      return null;
    }

    return null;
  }
}