import 'package:arquitectura_cliente_sistema_vision/core/services/navigation_service.dart';
import 'package:arquitectura_cliente_sistema_vision/core/services/toast_service.dart';
import 'package:arquitectura_cliente_sistema_vision/inject_container.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/ctrl_response.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_button.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/auth_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../clean_features/widgets/float_on_tap_text_field.dart';

class CreateAdminUserView extends StatefulWidget {

  CreateAdminUserView({super.key});

  @override
  State<CreateAdminUserView> createState() => _CreateAdminUserDialogState();
}

class _CreateAdminUserDialogState extends State<CreateAdminUserView> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  TextEditingController repeatPassCtrl = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorScheme colorScheme = theme.colorScheme;

    return Dialog(
      child: Container(
        width: 350,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24)
        ),
        child: SingleChildScrollView(
          child: Column(

            spacing: 25,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flex(
                direction: Axis.vertical,
                spacing: 10,
                children: [
                  //* Titulo
                  Text("Administrador", style: textTheme.headlineMedium,),
                  //* Description
                  Text(
                    "Crea tu primer cuenta de administrador",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge,
                  ),
                ],
              ),
              Form(
                key: formKey,
                child: Flex(
                  direction: Axis.vertical,
                  spacing: 10,
                  children: [
                    //* Usuario
                    FloatOnTapTextField(
                      controller: userNameCtrl,
                      hintText: "Nombre de usuario",
                      prefixIcon: Icons.person_outline,
                      fillColor: theme.scaffoldBackgroundColor,
                      validator: (value) {
                        if (value!.isEmpty) return "Campo requerido";
                      },
                    ),
                    //* Contraseña
                    FloatOnTapTextField(
                      controller: passCtrl,
                      hintText: "Ingresa una contraseña",
                      prefixIcon: Icons.password_outlined,
                      fillColor: theme.scaffoldBackgroundColor,
                      validator: (value) {
                        if (value!.isEmpty) return "Campo requerido";
                        bool same = passCtrl.text == repeatPassCtrl.text;
                        if (!same) return "Las contraseñas no son iguales";
                      },
                    ),
                    //* Repetir contraseña
                    FloatOnTapTextField(
                      controller: repeatPassCtrl,
                      hintText: "Repite la contraseña",
                      prefixIcon: Icons.password_outlined,
                      fillColor: theme.scaffoldBackgroundColor,
                      validator: (value) {
                        if (value!.isEmpty) return "Campo requerido";
                        bool same = passCtrl.text == repeatPassCtrl.text;
                        if (!same) return "Las contraseñas no son iguales";
                      },
                    ),
                  ],
                ),
              ),
              //* Cerrar
              CustomButton(
                text: "Crear",
                onTap: cta,
              )
            ],
          ),
        ),
      ),
    );
  }


  void cta() async {

    // Validar formulario
    if(!formKey.currentState!.validate()){
      return;
    }

    // Crear el administrador
    AuthController authController = context.read();
    context.loaderOverlay.show();
    CtrlResponse response = await authController.insertAdminUser(userNameCtrl.text, passCtrl.text);
    context.loaderOverlay.hide();

    if (response.success) {
      NavigationService navigationService = locator();
      navigationService.pushAndRemoveUntil(HomeView());
    } else {
      ToastService toastService = locator();
      toastService.error(response.message!);
    }

  }

}
