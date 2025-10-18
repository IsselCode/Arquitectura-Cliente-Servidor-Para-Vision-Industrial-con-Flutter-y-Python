import 'package:arquitectura_cliente_sistema_vision/core/app/theme.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/device_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'inject_container.dart';

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
       ChangeNotifierProvider(create: (context) => locator<DeviceController>(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightTheme,
        home: SplashView(),
      ),
    );
  }
}
