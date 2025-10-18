import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String text;
  final double height;
  final VoidCallback onTap;
  final FocusNode? focusNode;
  final Color? color;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
    this.focusNode,
    this.height = 60
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorScheme colorScheme = theme.colorScheme;
    return FilledButton(
      focusNode: focusNode,
      onPressed: onTap,
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: Size.fromHeight(height),
        backgroundColor: color
      ),
      child: Text(text, style: textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary, fontWeight: FontWeight.bold),)
    );
  }
}
