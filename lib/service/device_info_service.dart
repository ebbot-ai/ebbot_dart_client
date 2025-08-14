import 'device_info_stub.dart'
    if (dart.library.io) 'device_info_io.dart'
    if (dart.library.html) 'device_info_web.dart';

class DeviceInfoService {
  final PlatformDeviceInfo _platformDeviceInfo = PlatformDeviceInfo();

  Future<DeviceInfo?> getDeviceInfo() async {
    return await _platformDeviceInfo.getDeviceInfo();
  }
}
