import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:flutter/material.dart';
import 'package:issel_code_widgets/issel_code_widgets.dart';

enum ConfigEvalType {
  config,
  eval
}

class ConfigEvalDialog extends StatelessWidget {
  const ConfigEvalDialog({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorScheme colorScheme = theme.colorScheme;

    return Dialog(
      child: Container(
        width: 450,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24)
        ),
        child: Column(
          spacing: 25,
          mainAxisSize: MainAxisSize.min,
          children: [
            //* Imagen
            IsselAssetContainer(
              asset: AppAssets.db,
              height: 84,
              width: 84,
            ),
            //* Titulo
            Text("¿Qué harás?", style: textTheme.headlineMedium,),
            //* Action Boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 25,
              children: [
                IsselActionBox(
                  asset: AppAssets.pieza,
                  title: "Configurar",
                  height: 128,
                  width: 128,
                  color: theme.scaffoldBackgroundColor,
                  onTap: () => Navigator.pop(context, ConfigEvalType.config,),
                ),
                IsselActionBox(
                  asset: AppAssets.configuracion,
                  title: "Evaluar",
                  height: 128,
                  width: 128,
                  color: theme.scaffoldBackgroundColor,
                  onTap: () => Navigator.pop(context, ConfigEvalType.eval,),
                )
              ],
            ),
            //* Cancelar
            IsselButton(
              color: Colors.transparent,
              textColor: AppColors.grey,
              text: "Cancelar",
              onTap: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}
