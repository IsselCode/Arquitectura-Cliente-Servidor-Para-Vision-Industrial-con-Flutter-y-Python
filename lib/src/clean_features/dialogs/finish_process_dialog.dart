import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:flutter/material.dart';
import 'package:issel_code_widgets/issel_code_widgets.dart';

class FinishProcessDialog extends StatelessWidget {
  const FinishProcessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorScheme colorScheme = theme.colorScheme;

    return Dialog(
      child: SingleChildScrollView(
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
                asset: AppAssets.logo,
                height: 84,
                width: 84,
              ),

              Text("¿Ya te vas?", style: textTheme.headlineMedium,),

              //* Cuerpo
              Flex(
                spacing: 10,
                direction: Axis.vertical,
                children: [
                  //* Usuario
                  IsselDropdown<int>(
                    items: List.generate(5, (index) {
                      return DropdownMenuItem(
                        value: index,
                        child: Text(index.toString()),
                      );
                    },),
                    hintText: "Usuario",
                    color: theme.scaffoldBackgroundColor,
                    onChanged: (p0) {
                      print(p0);
                    },
                  ),

                  //* Campo de texto
                  IsselTextFormField(
                    // controller: nameCtrl,
                    height: 50,
                    hintText: "Contraseña",
                    prefixIcon: Icons.password_outlined,
                    fillColor: theme.scaffoldBackgroundColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Esto no puede estar vacío.";
                    },
                  ),
                ],
              ),
        
              //* Botónes
              Flex(
                spacing: 10,
                direction: Axis.vertical,
                children: [
                  //* Aceptar
                  IsselButton(
                    text: "Terminar",
                    color: Colors.red,
                    onTap: () => Navigator.pop(context, true),
                  ),
                  //* Cancelar
                  IsselButton(
                    color: Colors.transparent,
                    textColor: AppColors.grey,
                    text: "Regresar",
                    onTap: () => Navigator.pop(context, false),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
