import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class DeviceDetailScreen extends StatefulWidget {
  final DiscoveredDevice device;

  const DeviceDetailScreen({Key? key, required this.device}) : super(key: key);

  @override
  State<DeviceDetailScreen> createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name),
      ),
      body: Center(
        child: Text('Device ID: ${widget.device.id}'),
      ),
    );
  }
}
