import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/asset_container.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_button.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../clean_features/widgets/choice_card_group.dart';
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

              ChoiceCardGroup<Role>(
                value: role,
                onChanged: (v) => setState(() => role = v),
                size: 100,
                children: [
                  RadioCard(
                    value: Role.admin,
                    groupValue: role,
                    label: "Admin",
                    asset: "assets/logo.png",
                    onChanged: (p0) {
                      print(p0);
                    },
                  ),
                  RadioCard(
                    value: Role.calidad,
                    groupValue: role,
                    label: "Calidad",
                    asset: "assets/logo.png",
                    onChanged: (p0) {
                      print(p0);
                    },
                  ),
                  RadioCard(
                    value: Role.tecnico,
                    groupValue: role,
                    label: "Técnico",
                    asset: "assets/logo.png",
                    onChanged: (p0) {
                      print(p0);
                    },
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
