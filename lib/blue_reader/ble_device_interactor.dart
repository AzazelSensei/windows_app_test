import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BleDeviceInteractor {
  final _ble = FlutterReactiveBle();

  Future<List<int>> readCharacteristic(
      QualifiedCharacteristic characteristic) async {
    return await _ble.readCharacteristic(characteristic);
  }

  // Diğer yöntemler (writeWithResponse, writeWithoutResponse, subscribeToCharacteristic) buraya eklenebilir
}
