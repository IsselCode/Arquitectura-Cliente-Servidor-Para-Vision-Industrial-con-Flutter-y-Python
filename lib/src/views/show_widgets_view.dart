import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/asset_container.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_button.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_text_form_field.dart';
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
              )

            ],
          ),
        ),
      ),
    );
  }
}
