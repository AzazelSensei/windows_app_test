import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';
import 'package:windows_app_test/ble/ble_device_interactor.dart';

import 'ble/ble_logger.dart';
import 'ble/ble_scanner.dart';
import 'device_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final ble = FlutterReactiveBle();
  final bleLogger = BleLogger(ble: ble);
  final scanner = BleScanner(ble: ble, logMessage: bleLogger.addToLog);

  final serviceDiscoverer = BleDeviceInteractor(
    bleDiscoverServices: ble.discoverServices,
    readCharacteristic: ble.readCharacteristic,
    writeWithResponse: ble.writeCharacteristicWithResponse,
    writeWithOutResponse: ble.writeCharacteristicWithoutResponse,
    subscribeToCharacteristic: ble.subscribeToCharacteristic,
    logMessage: bleLogger.addToLog,
  );
  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: scanner),
        Provider.value(value: serviceDiscoverer),
        Provider.value(value: bleLogger),
        StreamProvider<BleScannerState?>(
          create: (_) => scanner.state,
          initialData: const BleScannerState(
            discoveredDevices: [],
            scanIsInProgress: false,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Reactive BLE example',
        color: Colors.blueGrey,
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        home: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive Flutter Template',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      home: const DeviceListScreen(),
    );
  }
}
