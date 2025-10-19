import 'package:arquitectura_cliente_sistema_vision/core/app/theme.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/camera_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/device_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'inject_container.dart';
import 'src/controller/logic/theme_controller.dart';

void main() async {

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
       ChangeNotifierProvider(create: (context) => locator<ThemeController>(),)
      ],
      child: Consumer<ThemeController>(
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: value.isDark ? darkTheme : lightTheme,
            home: SplashView(),
          );
        },
      ),
    );
  }
}
