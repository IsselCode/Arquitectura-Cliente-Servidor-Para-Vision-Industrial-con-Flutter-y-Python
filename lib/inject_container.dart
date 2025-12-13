import 'package:arquitectura_cliente_sistema_vision/core/database/user_dao.dart';
import 'package:arquitectura_cliente_sistema_vision/core/services/database_service.dart';
import 'package:arquitectura_cliente_sistema_vision/core/services/navigation_service.dart';
import 'package:arquitectura_cliente_sistema_vision/core/services/toast_service.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/auth_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/camera_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/database_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/device_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/theme_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/models/auth_model.dart';
import 'package:arquitectura_cliente_sistema_vision/src/models/camera_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'src/controller/logic/license_controller.dart';
import 'src/models/device_model.dart';
import 'src/models/license_model.dart';

GetIt locator = GetIt.instance;

Future<void> injectContainer() async {

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  FlutterSecureStorage storage = FlutterSecureStorage(
    aOptions: _getAndroidOptions(),
  );

  DatabaseService databaseService = DatabaseService();
  await databaseService.loadDatabase();

  // Packages
  locator.registerLazySingleton(() => storage,);
  locator.registerLazySingleton(() => FirebaseFirestore.instance,);

  // Dao´s
  locator.registerLazySingleton(() => UserDAO(db: databaseService.db),);

  // Services
  locator.registerLazySingleton(() => ToastService(),);
  locator.registerLazySingleton(() => NavigationService(),);
  locator.registerLazySingleton(() => databaseService,);

  // Models
  locator.registerLazySingleton(() => DeviceModel(),);
  locator.registerLazySingleton(() => CameraModel(),);
  locator.registerLazySingleton(() => LicenseModel(firestore: locator(), storage: locator()),);
  locator.registerLazySingleton(() => AuthModel(userDAO: locator()),);

  // Controllers


  // Controllers
  locator.registerLazySingleton(() => DeviceController(model: locator()),);
  locator.registerLazySingleton(() => CameraController(cameraModel: locator()),);
  locator.registerLazySingleton(() => ThemeController(),);
  locator.registerLazySingleton(() => LicenseController(licenseModel: locator<LicenseModel>(), deviceController: locator<DeviceController>()),);
  locator.registerLazySingleton(() => AuthController(authModel: locator()));
  locator.registerLazySingleton(() => DatabaseController());

}