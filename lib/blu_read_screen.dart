import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:intl/intl.dart';
import 'package:windows_app_test/asynchronous_button.dart';
import 'package:windows_app_test/blue_reader/ble_device_interactor.dart';

class BluReadScreen extends StatefulWidget {
  final String deviceId;
  const BluReadScreen({super.key, required this.deviceId});

  @override
  State<BluReadScreen> createState() => _BluReadScreenState();
}

class _BluReadScreenState extends State<BluReadScreen> {
  late QualifiedCharacteristic _characteristic;
  DateTime now = DateTime.now();

  String _readOutput = '';

  @override
  void initState() {
    super.initState();
    _characteristic = QualifiedCharacteristic(
      serviceId: Uuid.parse('45544942-4c55-4554-4845-524db87ad700'),
      characteristicId: Uuid.parse('45544942-4c55-4554-4845-524db87ad701'),
      deviceId: widget.deviceId,
    );
    _readCharacteristic();
  }

  Future<void> _readCharacteristic() async {
    final interactor = BleDeviceInteractor();

    double bytesToDouble(List<int> bytes) {
      final byteData = ByteData(8);
      for (var i = 0; i < bytes.length; i++) {
        byteData.setUint8(i, bytes[i]);
      }
      return byteData.getFloat32(0, Endian.little);
    }

    final readValue = await interactor.readCharacteristic(_characteristic);
    final value = bytesToDouble(readValue);
    setState(() {
      _readOutput = value.toString();
      now = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Read Characteristic Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AsynchronousButton(
                  onPressed: _readCharacteristic,
                  buttonText: 'Read Characteristic'),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Output: $_readOutput',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Date: $now',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
