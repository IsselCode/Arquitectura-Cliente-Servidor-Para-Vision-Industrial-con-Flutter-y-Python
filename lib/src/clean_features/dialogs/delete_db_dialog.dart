import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:flutter/material.dart';
import 'package:issel_code_widgets/issel_code_widgets.dart';

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
            IsselAssetContainer(
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
            IsselButton(
              text: "Eliminar",
              color: Colors.red,
              onTap: () => Navigator.pop(context, true),
            ),
            //* Cancelar
            IsselButton(
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
