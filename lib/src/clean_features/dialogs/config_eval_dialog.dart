import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/action_box.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/asset_container.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_button.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/config_machine_view.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/eval_view.dart';
import 'package:flutter/material.dart';

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
            AssetContainer(
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
                ActionBox(
                  asset: AppAssets.pieza,
                  title: "Configurar",
                  height: 128,
                  width: 128,
                  color: theme.scaffoldBackgroundColor,
                  onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ConfigMachineView(),)),
                ),
                ActionBox(
                  asset: AppAssets.configuracion,
                  title: "Evaluar",
                  height: 128,
                  width: 128,
                  color: theme.scaffoldBackgroundColor,
                  onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EvalView(),)),
                )
              ],
            ),
            //* Cancelar
            CustomButton(
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
