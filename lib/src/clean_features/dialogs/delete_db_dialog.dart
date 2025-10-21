import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/action_box.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/asset_container.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_button.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/config_machine_view.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/eval_view.dart';
import 'package:flutter/material.dart';

class DeleteDBDialog extends StatelessWidget {
  const DeleteDBDialog({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorScheme colorScheme = theme.colorScheme;

    return Dialog(
      child: Container(
        width: 350,
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
            Flex(
              direction: Axis.vertical,
              spacing: 10,
              children: [
                //* Titulo
                Text("¿Eliminar?", style: textTheme.headlineMedium,),
                //* Description
                SizedBox(
                  width: 280,
                  child: Text(
                    "¿Estas seguro que quieres remover esta base de datos?",
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  )
                ),
              ],
            ),
            //* Action Boxes
            CustomButton(
              text: "Eliminar",
              color: Colors.red,
              onTap: () => Navigator.pop(context, true),
            ),
            //* Cancelar
            CustomButton(
              color: Colors.transparent,
              textColor: AppColors.grey,
              text: "Cancelar",
              onTap: () => Navigator.pop(context, false),
            )
          ],
        ),
      ),
    );
  }
}
