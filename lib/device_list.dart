import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';

import 'ble/ble_logger.dart';
import 'ble/ble_scanner.dart';
import 'blu_read_screen.dart';

class DeviceListScreen extends StatelessWidget {
  const DeviceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Consumer3<BleScanner, BleScannerState?, BleLogger>(
        builder: (_, bleScanner, bleScannerState, bleLogger, __) => _DeviceList(
          scannerState: bleScannerState ??
              const BleScannerState(
                discoveredDevices: [],
                scanIsInProgress: false,
              ),
          startScan: bleScanner.startScan,
          stopScan: bleScanner.stopScan,
          toggleVerboseLogging: bleLogger.toggleVerboseLogging,
          verboseLogging: bleLogger.verboseLogging,
        ),
      );
}

class _DeviceList extends StatefulWidget {
  const _DeviceList({
    required this.scannerState,
    required this.startScan,
    required this.stopScan,
    required this.toggleVerboseLogging,
    required this.verboseLogging,
  });

  final BleScannerState scannerState;
  final void Function(List<Uuid>) startScan;
  final VoidCallback stopScan;
  final VoidCallback toggleVerboseLogging;
  final bool verboseLogging;

  @override
  _DeviceListState createState() => _DeviceListState();
}

class _DeviceListState extends State<_DeviceList> {
  late TextEditingController _uuidController;
  late final DiscoveredDevice device;

  @override
  void initState() {
    super.initState();
    _uuidController = TextEditingController()
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    widget.stopScan();
    _uuidController.dispose();
    super.dispose();
  }

  bool _isValidUuidInput() {
    final uuidText = _uuidController.text;
    if (uuidText.isEmpty) {
      return true;
    } else {
      try {
        Uuid.parse(uuidText);
        return true;
      } on Exception {
        return false;
      }
    }
  }

  void _startScanning() {
    final text = _uuidController.text;
    widget.startScan(text.isEmpty ? [] : [Uuid.parse(_uuidController.text)]);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Scan for devices'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 16),
                  // const Text('Service UUID (2, 4, 16 bytes):'),
                  // TextField(
                  //   controller: _uuidController,
                  //   enabled: !widget.scannerState.scanIsInProgress,
                  //   decoration: InputDecoration(
                  //       errorText:
                  //           _uuidController.text.isEmpty || _isValidUuidInput()
                  //               ? null
                  //               : 'Invalid UUID format'),
                  //   autocorrect: false,
                  // ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: !widget.scannerState.scanIsInProgress &&
                                _isValidUuidInput()
                            ? _startScanning
                            : null,
                        child: const Text('Scan'),
                      ),
                      ElevatedButton(
                        onPressed: widget.scannerState.scanIsInProgress
                            ? widget.stopScan
                            : null,
                        child: const Text('Stop'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: ListView(
                children: [
                  ListTile(
                    title: Text(
                      !widget.scannerState.scanIsInProgress
                          ? 'Enter a UUID above and tap start to begin scanning'
                          : 'Tap a device to connect to it',
                    ),
                    trailing: (widget.scannerState.scanIsInProgress ||
                            widget.scannerState.discoveredDevices.isNotEmpty)
                        ? Text(
                            'count: ${widget.scannerState.discoveredDevices.length}',
                          )
                        : null,
                  ),
                  ...widget.scannerState.discoveredDevices
                      .map(
                        (device) => ListTile(
                          title: Text(device.name),
                          subtitle: Text("${device.id}\nRSSI: ${device.rssi}"),
                          leading: const Icon(Icons.bluetooth),
                          onTap: () async {
                            widget.stopScan();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BluReadScreen(deviceId: device.id),
                              ),
                            );
                          },
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ],
        ),
      );
}
