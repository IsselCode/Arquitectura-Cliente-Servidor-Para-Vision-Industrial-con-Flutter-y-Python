import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/core/services/navigation_service.dart';
import 'package:arquitectura_cliente_sistema_vision/inject_container.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/database_selection_view.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/splash_view.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/user_management_view.dart';
import 'package:flutter/material.dart';
import 'package:issel_code_widgets/issel_code_widgets.dart';
import 'package:provider/provider.dart';

import '../controller/logic/theme_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;

    ThemeController themeController = context.watch();
    NavigationService navigationService = locator();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Stack(
            fit: StackFit.expand,
            children: [


              //* Tema y Salida
              Positioned(
                right: 20,
                child: Row(
                  spacing: 10,
                  children: [
                    IsselToggle(
                      height: 36,
                      width: 50,
                      backColor: colorScheme.surface,
                      value: themeController.isDark,
                      onChanged: (value) => themeController.isDark = value,
                    ),
                    IconButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SplashView(),),
                        (route) => false,
                      ),
                      icon: Icon(Icons.exit_to_app, color: Colors.red,),

                    ),
                  ],
                )
              ),

              //* Cuerpo
              Positioned.fill(
                child: Column(
                  spacing: 100,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("¿Qué quieres hacer hoy?", style: textTheme.displayLarge,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //* Configuración y evaluación
                        IsselActionBox(
                          asset: AppAssets.configuracion,
                          title: "Configuración y evaluación",
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DatabaseSelectionView(),));
                          },
                          width: 300,
                          height: 300,
                        ),
                        IsselActionBox(
                          asset: AppAssets.trazabilidad,
                          title: "Trazabilidad",
                          onTap: () {
                            print("navegando");
                          },
                          width: 300,
                          height: 300,
                        ),
                        IsselActionBox(
                          asset: AppAssets.usuarios,
                          title: "Gestionar Usuarios",
                          onTap: () {
                            navigationService.navigateTo(UserManagementView());
                          },
                          width: 300,
                          height: 300,
                        )
                      ],
                    )
                  ],
                )
              )
            ],
          ),
        ),
      )
    );
  }
}
