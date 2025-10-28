import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/action_box.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/asset_container.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_button.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_dropdown.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/config_machine_view.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/eval_view.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_text_form_field.dart';

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
              AssetContainer(
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
                  CustomDropdown<int>(
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
                  CustomTextFormField(
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
                  CustomButton(
                    text: "Terminar",
                    color: Colors.red,
                    onTap: () => Navigator.pop(context, true),
                  ),
                  //* Cancelar
                  CustomButton(
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
