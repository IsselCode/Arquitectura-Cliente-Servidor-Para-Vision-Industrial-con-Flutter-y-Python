import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/core/app/enums.dart';
import 'package:arquitectura_cliente_sistema_vision/core/services/toast_service.dart';
import 'package:arquitectura_cliente_sistema_vision/inject_container.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/ctrl_response.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_button.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_text_form_field.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/float_on_tap_text_field.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/radio_card.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class UserManagementCreatePage extends StatefulWidget {
  const UserManagementCreatePage({super.key});

  @override
  State<UserManagementCreatePage> createState() => _UserManagementCreatePageState();
}

class _UserManagementCreatePageState extends State<UserManagementCreatePage> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  AppRole selectedRole = AppRole.admin;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorScheme colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          spacing: 30,
          children: [
            //* Inputs
            Form(
              key: formKey,
              child: Flex(
                direction: Axis.vertical,
                spacing: 10,
                children: [
                  FloatOnTapTextField(
                    controller: username,
                    hintText: "Nombre de usuario",
                    prefixIcon: Icons.person_outline,
                    fillColor: theme.scaffoldBackgroundColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Campo requerido";
                    },
                  ),
                  FloatOnTapTextField(
                    controller: password,
                    hintText: "Contraseña",
                    prefixIcon: Icons.password_outlined,
                    fillColor: theme.scaffoldBackgroundColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Campo requerido";
                    },
                  )
                ],
              ),
            ),
            //* Roles
            Row(
              spacing: 20,
              children: [
                RadioCard(
                  value: AppRole.admin,
                  groupValue: selectedRole,
                  label: "Administrador",
                  asset: AppAssets.admin,
                  surfaceColor: theme.scaffoldBackgroundColor,
                  onChanged: (v) => setState(() => selectedRole = v)
                ),
                RadioCard(
                  value: AppRole.technician,
                  groupValue: selectedRole,
                  label: "Técnico",
                  asset: AppAssets.technician,
                  surfaceColor: theme.scaffoldBackgroundColor,
                  onChanged: (v) => setState(() => selectedRole = v)
                ),
                RadioCard(
                  value: AppRole.quality,
                  groupValue: selectedRole,
                  label: "Calidad",
                  asset: AppAssets.quality,
                  surfaceColor: theme.scaffoldBackgroundColor,
                  onChanged: (v) => setState(() => selectedRole = v)
                )
              ],
            ),
            //* Botón de registrar
            CustomButton(
              text: "Registrar",
              onTap: () => cta(),
            )
          ],
        ),
      ),
    );
  }

  void cta() async {

    if (!formKey.currentState!.validate()){
      return ;
    }


    context.loaderOverlay.show();
    AuthController authController = context.read();
    CtrlResponse response = await authController.insertNormalUser(username.text, password.text, selectedRole);
    context.loaderOverlay.hide();

    ToastService toastService = locator();

    if (response.success) {
      toastService.success(response.message!);
      // Reiniciamos controladores
      username.text = "";
      password.text = "";
      selectedRole = AppRole.admin;
      setState(() {});
    } else {
      toastService.error(response.message!);
    }

  }

}
