import 'package:arquitectura_cliente_sistema_vision/core/services/navigation_service.dart';
import 'package:arquitectura_cliente_sistema_vision/core/services/toast_service.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/camera_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/device_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/theme_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/models/camera_model.dart';
import 'package:get_it/get_it.dart';

import 'src/controller/logic/license_controller.dart';
import 'src/models/device_model.dart';
import 'src/models/license_model.dart';

GetIt locator = GetIt.instance;

Future<void> injectContainer() async {

  // Services
  locator.registerLazySingleton(() => ToastService(),);
  locator.registerLazySingleton(() => NavigationService(),);

  // Models
  locator.registerLazySingleton(() => DeviceModel(),);
  locator.registerLazySingleton(() => CameraModel(),);
  locator.registerLazySingleton(() => LicenseModel(),);

  // Controllers


  // Controllers
  locator.registerLazySingleton(() => DeviceController(model: locator()),);
  locator.registerLazySingleton(() => CameraController(cameraModel: locator()),);
  locator.registerLazySingleton(() => ThemeController(),);
  locator.registerLazySingleton(() => LicenseController(licenseModel: locator<LicenseModel>(), deviceController: locator<DeviceController>()),);

}