import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/asset_container.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class ShowWidgetsView extends StatelessWidget {
  const ShowWidgetsView({super.key});

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
                height: 60,
              )

            ],
          ),
        ),
      ),
    );
  }
}
