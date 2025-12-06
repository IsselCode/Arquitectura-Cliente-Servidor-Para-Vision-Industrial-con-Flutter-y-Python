import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/core/app/enums.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_text_form_field.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/radio_card.dart';
import 'package:flutter/material.dart';

class UserManagementCreatePage extends StatefulWidget {
  const UserManagementCreatePage({super.key});

  @override
  State<UserManagementCreatePage> createState() => _UserManagementCreatePageState();
}

class _UserManagementCreatePageState extends State<UserManagementCreatePage> {

  AppRole selectedRole = AppRole.admin;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorScheme colorScheme = theme.colorScheme;

    return Column(
      spacing: 40,
      children: [
        //* Inputs
        Flex(
          direction: Axis.vertical,
          spacing: 10,
          children: [
            CustomTextFormField(
              hintText: "Nombre de usuario",
              prefixIcon: Icons.person_outline,
              fillColor: theme.scaffoldBackgroundColor,
            ),
            CustomTextFormField(
              hintText: "Contraseña",
              prefixIcon: Icons.password_outlined,
              fillColor: theme.scaffoldBackgroundColor,
            )
          ],
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
      ],
    );
  }
}
