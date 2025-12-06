import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/core/services/navigation_service.dart';
import 'package:arquitectura_cliente_sistema_vision/core/services/toast_service.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/ctrl_response.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/asset_container.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_button.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/float_on_tap_text_field.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/auth_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/home_view.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/scan_devices_view.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../../inject_container.dart';
import 'create_admin_user_view.dart';

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
            validator: (value) {
              if (value!.isEmpty) return "Campo requerido";
            },
          ),

          FloatOnTapTextField(
            controller: password,
            hintText: "Contraseña",
            prefixIcon: Icons.lock_outline,
            fillColor: theme.scaffoldBackgroundColor,
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) return "Campo requerido";
            },
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

    if (!formKey.currentState!.validate()){
      return ;
    }

    context.loaderOverlay.show();
    AuthController authController = context.read();
    CtrlResponse response = await authController.authenticate(userName.text, password.text);
    context.loaderOverlay.hide();

    ToastService toastService = locator();
    NavigationService navigationService = locator();
    if (response.success){
      navigationService.pushAndRemoveUntil(ScanDevicesView());
    } else {
      toastService.error(response.message!);
    }

  }

}
