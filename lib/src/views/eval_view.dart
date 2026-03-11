import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/dialogs/finish_process_dialog.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/text_back_button.dart';

import 'package:flutter/material.dart';
import 'package:issel_code_widgets/issel_code_widgets.dart';

class EvalView extends StatelessWidget {

  const EvalView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorScheme colorScheme = theme.colorScheme;


    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Row(
              spacing: 50,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //! Left Panel
                SizedBox(
                  width: 300,
                  child: _leftPanel(context),
                ),

                //! Right Panel
                Expanded(
                  child: Stack(
                    children: [
                      TextBackButton(),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: colorScheme.surface,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: AspectRatio(
                              aspectRatio: 16/9
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  Widget _leftPanel(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorScheme colorScheme = theme.colorScheme;

    return Column(
      spacing: 10,
      children: [
        //* Dirección del PLC
        Flex(
          spacing: 10,
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Información General",
              textAlign: TextAlign.center,
              style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),),
            Divider(color: AppColors.grey,),
            Text("QR Leído", style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
            IsselInfoField2(
              height: 50,
              label: "545914523539",
              icon: Icons.qr_code_2_outlined,
            ),
            Text("Duración de la prueba", style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
            IsselInfoField2(
              height: 50,
              label: "12s",
              icon: Icons.access_time_outlined,
            ),
            Text("Fecha del sistema", style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
            IsselInfoField2(
              height: 50,
              label: "asd",
              icon: Icons.calendar_month_outlined,
            ),
            IsselInfoField(
              height: 50,
              title: "Piezas Ok",
              value: "1",
            ),
            IsselInfoField(
              height: 50,
              title: "Piezas NG",
              value: "1",
            ),
          ],
        ),

        Spacer(),

        // Terminar proceso
        IsselButton(
          text: "Terminar proceso",
          color: Colors.red,
          onTap: () async {
            bool? result = await showDialog(
              context: context,
              builder: (context) => FinishProcessDialog(),
            );

            print(result);
          },
        )
      ],
    );
  }
}
