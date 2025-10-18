import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/action_box.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_toggle.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/theme_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/database_selection_view.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = context.watch();

    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Stack(
            fit: StackFit.expand,
            children: [

              Positioned(
                right: 20,
                child: Row(
                  spacing: 10,
                  children: [
                    CustomToggle(
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
                        ActionBox(
                          asset: AppAssets.configuracion,
                          title: "Configuración y evaluación",
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DatabaseSelectionView(),));
                          },
                          width: 300,
                          height: 300,
                        ),
                        ActionBox(
                          asset: AppAssets.trazabilidad,
                          title: "Trazabilidad",
                          onTap: () {
                            print("navegando");
                          },
                          width: 300,
                          height: 300,
                        ),
                        ActionBox(
                          asset: AppAssets.usuarios,
                          title: "Gestionar Usuarios",
                          onTap: () {
                            print("navegando");
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
