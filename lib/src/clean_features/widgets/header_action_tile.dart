import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../core/app/consts.dart';

class HeaderActionTile extends StatelessWidget {

  final double height;
  final String textButton;
  final String title;
  final String subTitle;
  final VoidCallback onPressed;

  const HeaderActionTile({
    super.key,
    this.height = 50,
    required this.textButton,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;

    return Container(
      height: height,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        spacing: 10,
        children: [

          //* Text
          Expanded(
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary),
                ),
                Text(
                  title,
                  style: textTheme.bodySmall?.copyWith(color: AppColors.grey),
                )
              ],
            ),
          ),

          //* Buttón
          Expanded(
            child: CustomButton(
              text: textButton,
              onTap: onPressed
            )
          )
        ],
      ),
    );
  }
}
