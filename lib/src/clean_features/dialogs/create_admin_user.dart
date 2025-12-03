import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/core/utils/credentials_generator_util.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/asset_container.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_button.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_text_form_field.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/info_field_2.dart';
import 'package:flutter/material.dart';

class CreateAdminUserDialog extends StatefulWidget {

  CreateAdminUserDialog({super.key});

  @override
  State<CreateAdminUserDialog> createState() => _CreateAdminUserDialogState();
}

class _CreateAdminUserDialogState extends State<CreateAdminUserDialog> {

  late String username;
  late String password;

  @override
  void initState() {
    super.initState();
    username = CredentialsGeneratorUtil.generateUsername(randomDigits: 8);
    password = CredentialsGeneratorUtil.generatePassword(length: 6);
  }

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
                ],
              ),
              //* Usuario
              InfoField2(
                label: username,
                copy: true,
                icon: Icons.person_outline,
                backColor: theme.scaffoldBackgroundColor,
              ),
              // Contraseña
              InfoField2(
                label: password,
                copy: true,
                icon: Icons.password_outlined,
                backColor: theme.scaffoldBackgroundColor,
              ),
              //* Cerrar
              CustomButton(
                color: Colors.transparent,
                textColor: Colors.red,
                text: "Cerrar",
                onTap: () => Navigator.pop(context, true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
