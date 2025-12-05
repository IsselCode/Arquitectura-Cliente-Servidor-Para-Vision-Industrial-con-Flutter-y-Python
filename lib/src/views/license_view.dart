import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/core/services/navigation_service.dart';
import 'package:arquitectura_cliente_sistema_vision/core/services/toast_service.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/create_admin_user_view.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/ctrl_response.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/asset_container.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_button.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/float_on_tap_text_field.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/auth_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/license_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/home_view.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../../inject_container.dart';

class LicenseView extends StatelessWidget {
  const LicenseView({super.key});

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

                Text("Licencia", style: textTheme.displayMedium,),

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
  TextEditingController license = TextEditingController();

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
            controller: license,
            hintText: "XXXXXXXXXXXXXXXX",
            prefixIcon: Icons.workspace_premium_outlined,
            fillColor: theme.scaffoldBackgroundColor,
            validator: (value) {
              if (value == null || value.isEmpty) return "Campo requerido";
              if (value.length != 16) return "Ingresa una licencia válida";
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

    if (!formKey.currentState!.validate()) {
      return;
    }

    ToastService toastService = locator();
    LicenseController licenseController = context.read();
    AuthController authController = context.read();

    // Activamos la licencia
    context.loaderOverlay.show();
    CtrlResponse response = await licenseController.activateLicense(license.text);
    context.loaderOverlay.hide();

    if (response.success) {
      toastService.success("Licencia activada");

      // Crear usuario (ADMIN)
      NavigationService navigationService = locator();
      navigationService.pushAndRemoveUntil(CreateAdminUserView());

    } else {
      toastService.error(response.message!);
    }


  }

}
