import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/asset_container.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_button.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_text_form_field.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/float_on_tap_text_field.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Container(
            width: 360,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(24)
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 20,
              children: [

                AssetContainer(asset: AppAssets.logo, color: theme.scaffoldBackgroundColor,),

                Text("¡Bienvenido!", style: textTheme.displayMedium,),

                _Form()

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;

    return Column(
      spacing: 10,
      children: [

        // FloatOnTapTextField(
        //   controller: TextEditingController(),
        //   hintText: "Nombre de usuario",
        //   prefixIcon: Icons.person_outline,
        //   fillColor: theme.scaffoldBackgroundColor,
        //   obscureText: false,
        //   compactDisplayBuilder: (ctx, controller, openOverlay) {
        //     return CustomTextFormField(
        //       controller: controller,
        //       onTap: openOverlay,
        //       readOnly: true,
        //       hintText: "Nombre de usuario",
        //       prefixIcon: Icons.person_outline,
        //       fillColor: theme.scaffoldBackgroundColor,
        //       obscureText: true,
        //     );
        //   },
        // ),

        CustomTextFormField(
          controller: TextEditingController(),
          hintText: "Usuario",
          prefixIcon: Icons.person_outline,
          fillColor: theme.scaffoldBackgroundColor,
        ),

        CustomTextFormField(
          controller: TextEditingController(),
          hintText: "Contraseña",
          prefixIcon: Icons.lock_outline,
          fillColor: theme.scaffoldBackgroundColor,
          obscureText: true,
        ),

        const SizedBox(height: 10,),
        
        CustomButton(
          text: "Ingresar",
          onTap: () {
            print("Ingresar");
          },
        )

      ],
    );
  }
}
