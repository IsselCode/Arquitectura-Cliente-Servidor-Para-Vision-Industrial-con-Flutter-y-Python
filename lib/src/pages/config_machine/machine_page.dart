

import 'package:flutter/material.dart';
import 'package:issel_code_widgets/issel_code_widgets.dart';
import 'package:provider/provider.dart';

import '../../../core/app/consts.dart';
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

              IsselFloatTextField(
                height: 50,
                controller: configMachineCtrl.plcIp,
                hintText: "192.168.x.y:0000",
                prefixIcon: Icons.lock_outline
              ),

              IsselButton(
                text: "Asignar",
                onTap: configMachineCtrl.connectToPlc,
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
              Text("Salidas", style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
              IsselHeaderActionTile(
                textButton: "Probar",
                title: "Iluminación Q1",
                subTitle: "Salida",
                onPressed: configMachineCtrl.testIllumination,
              ),
              IsselHeaderActionTile(
                textButton: "Probar",
                title: "Señal Ok",
                subTitle: "Salida",
                onPressed: configMachineCtrl.testOkSignal,
              ),
              IsselHeaderActionTile(
                textButton: "Probar",
                title: "Señal NG",
                subTitle: "Salida",
                onPressed: configMachineCtrl.testNotOkSignal,
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
              IsselInfoField(title: "Piezas Ok", value: "1"),
              IsselInfoField(title: "Piezas NG", value: "1"),
              IsselButton(
                text: "Reiniciar Contadores",
                color: Colors.red,
                onTap: configMachineCtrl.resetCounters
              )
            ],
          )
        ],
      ),
    );
  }
}
