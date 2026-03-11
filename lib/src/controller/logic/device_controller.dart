import 'package:arquitectura_cliente_sistema_vision/core/services/host_port_device_service.dart';
import 'package:flutter/material.dart';

import '../../clean_features/entities/device_entity.dart';
import '../../models/device_model.dart';

class DeviceController extends ChangeNotifier {

  DeviceModel model;
  HostPortDeviceService hostPortDeviceService;

  DeviceController({
    required this.model,
    required this.hostPortDeviceService
  });


  // Device
  DeviceEntity? _device;
  DeviceEntity? get device => _device;
  set device(DeviceEntity? value) {
    _device = value;
    hostPortDeviceService.configure(host: _device!.host, port: _device!.port.toString());
  }

  //
  Future<List<DeviceEntity>> discoverWithNsd() => model.discoverWithNsd();

}