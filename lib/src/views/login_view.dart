import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/core/services/service_loader.dart';
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

  _Form({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;

    return Form(
      key: formKey,
      child: Column(
        spacing: 10,
        children: [

          FloatOnTapTextField(
            controller: userName,
            hintText: "Nombre de usuario",
            prefixIcon: Icons.person_outline,
            fillColor: theme.scaffoldBackgroundColor,
          ),

          FloatOnTapTextField(
            controller: password,
            hintText: "Contraseña",
            prefixIcon: Icons.lock_outline,
            fillColor: theme.scaffoldBackgroundColor,
            obscureText: true,
          ),

          const SizedBox(height: 10,),

          CustomButton(
            text: "Ingresar",
            onTap: () => cta(context),
          )

        ],
      ),
    );
  }

  cta(BuildContext context) async {

    bool? result = await ServiceLoader.loader<bool>(
      context: context,
      future: Future.delayed(const Duration(milliseconds: 500), () => false,)
    );

    print(result);

  }

}
