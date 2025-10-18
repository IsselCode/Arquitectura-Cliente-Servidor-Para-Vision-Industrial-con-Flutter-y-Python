import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_toggle.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/theme_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/database_selecion_view.dart';
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
                        _ActionBox(
                          image: AppAssets.configuracion,
                          text: "Configuración y evaluación",
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DatabaseSelecionView(),));
                          },
                        ),
                        _ActionBox(
                          image: AppAssets.trazabilidad,
                          text: "Trazabilidad",
                          onTap: () {
                            print("navegando");
                          },
                        ),
                        _ActionBox(
                          image: AppAssets.usuarios,
                          text: "Gestionar Usuarios",
                          onTap: () {
                            print("navegando");
                          },
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

class _ActionBox extends StatelessWidget {

  final String image;
  final String text;
  final VoidCallback onTap;

  const _ActionBox({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;


    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      child: InkResponse(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          padding: EdgeInsets.all(20),
          height: 350,
          width: 350,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(24)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 40,
            children: [
              Image.asset(image, height: 128, width: 128,),
              SizedBox(
                height: 70,
                child: Center(child: Text(text, style: textTheme.titleLarge, textAlign: TextAlign.center,))
              )
            ],
          ),
        ),
      ),
    );
  }
}
