import 'package:flutter/material.dart';

import '../clean_features/entities/device_entity.dart';
import '../models/device_model.dart';

class DeviceController extends ChangeNotifier {

  DeviceModel model;

  DeviceController({
    required this.model,
  });

  DeviceEntity? device;
  Future<List<DeviceEntity>> discoverWithNsd() => model.discoverWithNsd();

}