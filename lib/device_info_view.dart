import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class DeviceInfoView extends StatefulWidget {
  const DeviceInfoView({super.key});

  @override
  State<DeviceInfoView> createState() => _DeviceInfoViewState();
}

class _DeviceInfoViewState extends State<DeviceInfoView> {
  String deviceModel = "detecting...";

  String osVersion = "detecting...";

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  Future<void> _getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    //checking which is platform

    //android case
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      setState(() {
        deviceModel = androidInfo.model;
        osVersion = "Android ${androidInfo.version.release}";
      });
      //windows case
    } else if (Platform.isWindows) {
      WindowsDeviceInfo windowsDeviceInfo = await deviceInfo.windowsInfo;
      setState(() {
        deviceModel = windowsDeviceInfo.computerName;
        osVersion = "windows ${windowsDeviceInfo.majorVersion}";
      });
      //ios case
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      setState(() {
        deviceModel = iosInfo.utsname.machine;
        osVersion = "IOS ${iosInfo.systemVersion}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Device Info")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Device Model: $deviceModel",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("OS Version: $osVersion",
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
