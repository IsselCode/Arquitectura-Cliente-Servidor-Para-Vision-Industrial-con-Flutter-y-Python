import 'package:arquitectura_cliente_sistema_vision/src/controller/device_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/theme_controller.dart';
import 'package:get_it/get_it.dart';

import 'src/models/device_model.dart';

GetIt locator = GetIt.instance;

Future<void> injectContainer() async {

  locator.registerLazySingleton(() => DeviceModel(),);

  locator.registerLazySingleton(() => DeviceController(model: locator()),);
  locator.registerLazySingleton(() => ThemeController(),);

}