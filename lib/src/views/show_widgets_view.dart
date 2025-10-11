import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/asset_container.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_button.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_text_form_field.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/info_field.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/stepper_field.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/tab_switcher.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/header_action_tile.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/radio_tile.dart';
import 'package:flutter/material.dart';

import '../clean_features/widgets/radio_card.dart';

enum Role {
  admin,
  calidad,
  tecnico
}

class ShowWidgetsView extends StatefulWidget {
  const ShowWidgetsView({super.key});

  @override
  State<ShowWidgetsView> createState() => _ShowWidgetsViewState();
}

class _ShowWidgetsViewState extends State<ShowWidgetsView> {

  Role? role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 320),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [

              AssetContainer(asset: "assets/logo.png"),

              CustomTextFormField(
                hintText: "Nombre de usuario",
                prefixIcon: Icons.person_outline,
                height: 50,
              ),

              CustomButton(
                text: "Ingresar",
                onTap: () => print("Ingresando"),
              ),

              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RadioCard(
                    value: Role.admin,
                    groupValue: role,
                    size: 100,
                    label: "Admin",
                    asset: "assets/logo.png",
                    onChanged: (v) => setState(() => role = v)
                  ),
                  RadioCard(
                    value: Role.calidad,
                    groupValue: role,
                    size: 100,
                    label: "Calidad",
                    asset: "assets/logo.png",
                    onChanged: (v) => setState(() => role = v)
                  ),
                  RadioCard(
                    value: Role.tecnico,
                    groupValue: role,
                    size: 100,
                    label: "Técnico",
                    asset: "assets/logo.png",
                    onChanged: (v) => setState(() => role = v)
                  ),
                ],
              ),

              SizedBox(
                height: 170,
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RadioTile(
                      value: Role.admin,
                      groupValue: role,
                      height: 50,
                      label: "Admin",
                      asset: "assets/logo.png",
                      onChanged: (v) => setState(() => role = v),
                      alignment: Alignment.centerLeft,
                    ),
                    RadioTile(
                      value: Role.calidad,
                      groupValue: role,
                      height: 50,
                      label: "Calidad",
                      asset: "assets/logo.png",
                      onChanged: (v) => setState(() => role = v),
                      alignment: Alignment.centerLeft,
                    ),
                    RadioTile(
                      value: Role.tecnico,
                      groupValue: role,
                      height: 50,
                      label: "Técnico",
                      asset: "assets/logo.png",
                      onChanged: (v) => setState(() => role = v),
                      alignment: Alignment.centerLeft,
                    ),
                  ],
                ),
              ),

              HeaderActionTile(
                title: "Iluminación Q1",
                subTitle: "Salida",
                textButton: "Probar",
                onPressed: () {

                },
              ),

              CustomWidget(
                leftText: "Crear",
                rightText: "Actualizar",
                state: (value) {
                  print(value);
                },
              ),

              StepperField(
                title: "Exposición",
                maxValue: 20,
                minValue: -10,
                onChanged: (value) {
                  print(value);
                }
              ),

              InfoField(
                title: "Piezas Ok",
                value: "5"
              )



            ],
          ),
        ),
      ),
    );
  }
}
