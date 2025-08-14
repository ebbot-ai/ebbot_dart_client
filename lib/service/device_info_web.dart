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
      final info = await deviceInfoPlugin.webBrowserInfo;
      return DeviceInfo(
          deviceName: info.browserName.toString(),
          deviceModel: info.platform.toString(),
          os: 'Web',
          osVersion: info.appVersion.toString(),
          platform: 'web');
    } catch (e) {
      return null;
    }
  }
}