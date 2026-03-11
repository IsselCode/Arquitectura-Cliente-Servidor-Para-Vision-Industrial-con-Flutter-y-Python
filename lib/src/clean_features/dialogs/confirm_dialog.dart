import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:flutter/material.dart';
import 'package:issel_code_widgets/issel_code_widgets.dart';

class ConfirmDialog extends StatelessWidget {

  final String title;
  final String message;
  final String textButton;

  ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.textButton = "Confirmar"
  });

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
        child: SingleChildScrollView(
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
                  Text(title, style: textTheme.headlineMedium,),
                  //* Description
                  Text(message, style: textTheme.bodyMedium, textAlign: TextAlign.center,),
                ],
              ),
              //* Action Boxes
              IsselButton(
                text: textButton,
                onTap: () {
                  Navigator.pop(context, true);
                },
              ),
              //* Cancelar
              IsselButton(
                color: Colors.transparent,
                textColor: AppColors.grey,
                text: "¡No, Gracias!",
                onTap: () => Navigator.pop(context, false),
              )
            ],
          ),
        ),
      ),
    );
  }
}
