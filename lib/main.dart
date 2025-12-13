import 'package:arquitectura_cliente_sistema_vision/core/app/theme.dart';
import 'package:arquitectura_cliente_sistema_vision/core/services/navigation_service.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/database_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/create_admin_user_view.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/auth_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/camera_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/device_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/license_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/home_view.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import 'firebase_options.dart';
import 'inject_container.dart';
import 'src/controller/logic/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await injectContainer();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       ChangeNotifierProvider(create: (context) => locator<CameraController>(),),
       ChangeNotifierProvider(create: (context) => locator<DeviceController>(),),
       ChangeNotifierProvider(create: (context) => locator<ThemeController>(),),
       ChangeNotifierProvider(create: (context) => locator<LicenseController>(),),
       ChangeNotifierProvider(create: (context) => locator<AuthController>(),),
       ChangeNotifierProvider(create: (context) => locator<DatabaseController>(),)
      ],
      child: GlobalLoaderOverlay(
        child: ToastificationWrapper(
          child: Consumer<ThemeController>(
            builder: (context, value, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                navigatorKey: locator<NavigationService>().navigatorKey,
                theme: value.isDark ? darkTheme : lightTheme,
                // home: SplashView(),
                home: HomeView(),
              );
            },
          ),
        ),
      ),
    );
  }
}
