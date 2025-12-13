

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/app/consts.dart';
import '../../clean_features/widgets/custom_button.dart';
import '../../clean_features/widgets/float_on_tap_text_field.dart';
import '../../clean_features/widgets/header_action_tile.dart';
import '../../clean_features/widgets/info_field.dart';
import '../../controller/ui/config_machine_ctrl.dart';

class MachinePage extends StatelessWidget {
  const MachinePage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorScheme colorScheme = theme.colorScheme;
    ConfigMachineCtrl configMachineCtrl = context.watch();

    return SingleChildScrollView(
      child: Flex(
        direction: Axis.vertical,
        spacing: 10,
        children: [
          //* Dirección del PLC
          Flex(
            spacing: 10,
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Dirección IP del PLC", style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
              FloatOnTapTextField(
                  height: 50,
                  controller: TextEditingController(),
                  hintText: "192.168.x.y:0000",
                  prefixIcon: Icons.lock_outline
              ),
              CustomButton(
                text: "Asignar",
                onTap: () => print("Asignando"),
              )
            ],
          ),
          Divider(color: AppColors.grey,),

          //* Salidas
          Flex(
            direction: Axis.vertical,
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Dirección IP del PLC", style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
              HeaderActionTile(
                textButton: "Probar",
                title: "Iluminación Q1",
                subTitle: "Salida",
                onPressed: () => print("Probando Iluminación Q1"),
              ),
              HeaderActionTile(
                textButton: "Probar",
                title: "Señal Ok",
                subTitle: "Salida",
                onPressed: () => print("Probando Señal Ok"),
              ),
              HeaderActionTile(
                textButton: "Probar",
                title: "Señal NG",
                subTitle: "Salida",
                onPressed: () => print("Probando Señal NG"),
              )
            ],
          ),
          Divider(color: AppColors.grey,),

          //* Contadores
          Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 10,
            children: [
              InfoField(title: "Piezas Ok", value: "1"),
              InfoField(title: "Piezas NG", value: "1"),
              CustomButton(
                text: "Reiniciar Contadores",
                color: Colors.red,
                onTap: () => print("Reiniciando Contadores"),
              )
            ],
          )
        ],
      ),
    );
  }
}
