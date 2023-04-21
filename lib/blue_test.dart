import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ColdPresentationScreen extends StatefulWidget {
  const ColdPresentationScreen({super.key});

  @override
  State<ColdPresentationScreen> createState() => _ColdPresentationScreenState();
}

class _ColdPresentationScreenState extends State<ColdPresentationScreen> {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;
  StreamSubscription<ScanResult>? _scanSubscription;
  BluetoothDevice? _tempestBlueThermometer;

  void _startScan() {
    _scanSubscription = _flutterBlue.scan().listen((scanResult) {
      // Tempest Blue Thermometer cihazını bul
      if (scanResult.advertisementData.localName ==
          'Tempest Blue Thermometer') {
        _connectToDevice(scanResult.device);
        _stopScan();
      }
    });
  }

  void _stopScan() {
    _scanSubscription?.cancel();
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    await device.connect();
    setState(() {
      _tempestBlueThermometer = device;
    });

    // Hizmetleri ve özellikleri keşfet
    List<BluetoothService> services = await device.discoverServices();
    for (var service in services) {
      // Termometre servisini ve özelliklerini bul
      if (service.uuid == Guid('22405689 TempTest Blue')) {
        for (var characteristic in service.characteristics) {
          if (characteristic.uuid == Guid('60:8A:10:92:79:6F')) {
            // Veri okuma
            _readTemperature(characteristic);
          }
        }
      }
    }
  }

  Future<void> _readTemperature(BluetoothCharacteristic characteristic) async {
    var temperatureData = await characteristic.read();
    debugPrint('Sıcaklık: $temperatureData');
  }

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  @override
  void dispose() {
    _stopScan();
    _tempestBlueThermometer?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Tempest Blue Thermometer',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              _tempestBlueThermometer == null
                  ? 'Cihaz bağlı değil'
                  : 'Cihaz bağlı: ${_tempestBlueThermometer!.name}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: _tempestBlueThermometer == null ? null : _disconnect,
              child: const Text('Bağlantıyı Kes'),
            ),
          ],
        ),
      ),
    );
  }

  void _disconnect() {
    _tempestBlueThermometer?.disconnect();
    setState(() {
      _tempestBlueThermometer = null;
    });
  }
}
