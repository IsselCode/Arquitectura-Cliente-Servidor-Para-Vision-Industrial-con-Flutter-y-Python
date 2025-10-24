import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/action_box.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/asset_container.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_button.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_text_form_field.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/float_on_tap_text_field.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/config_machine_view.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/eval_view.dart';
import 'package:flutter/material.dart';

class AddDBDialog extends StatelessWidget {

  final TextEditingController nameCtrl = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();

  AddDBDialog({super.key});

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
          child: Form(
            key: form,
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
                    Text("Crear", style: textTheme.headlineMedium,),
                    //* Description
                  ],
                ),
                //* Campo de texto
                CustomTextFormField(
                  controller: nameCtrl,
                  hintText: "Base de datos",
                  prefixIcon: Icons.ac_unit,
                  fillColor: theme.scaffoldBackgroundColor,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Esto no puede estar vacío.";
                  },
                ),
                //* Action Boxes
                CustomButton(
                  text: "Crear",
                  onTap: () {

                    if (!form.currentState!.validate()) {
                      return ;
                    }

                    Navigator.pop(context, nameCtrl.text);
                  },
                ),
                //* Cancelar
                CustomButton(
                  color: Colors.transparent,
                  textColor: AppColors.grey,
                  text: "¡No, Gracias!",
                  onTap: () => Navigator.pop(context, null),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
