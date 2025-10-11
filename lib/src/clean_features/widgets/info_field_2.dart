import 'package:flutter/material.dart';

import '../../../core/app/consts.dart';

class InfoField2 extends StatelessWidget {

  final IconData icon;
  final String label;
  final double height;
  final Color? backColor;

  const InfoField2({
    super.key,
    required this.icon,
    required this.label,
    this.height = 50,
    this.backColor,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;

    return Container(
      height: height,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: backColor ?? colorScheme.surface,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        spacing: 10,
        children: [
          // Icon
          Icon(icon, color: AppColors.grey,),
          // Text
          Expanded(
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(color: AppColors.grey),
            )
          ),
        ],
      ),
    );
  }
}
