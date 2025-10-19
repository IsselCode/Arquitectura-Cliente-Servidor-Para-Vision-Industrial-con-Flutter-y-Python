import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/camera_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/device_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/theme_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/models/camera_model.dart';
import 'package:get_it/get_it.dart';

import 'src/models/device_model.dart';

GetIt locator = GetIt.instance;

Future<void> injectContainer() async {

  locator.registerLazySingleton(() => DeviceModel(),);
  locator.registerLazySingleton(() => CameraModel(),);

  locator.registerLazySingleton(() => CameraController(cameraModel: locator()),);

  locator.registerLazySingleton(() => DeviceController(model: locator()),);
  locator.registerLazySingleton(() => ThemeController(),);

}