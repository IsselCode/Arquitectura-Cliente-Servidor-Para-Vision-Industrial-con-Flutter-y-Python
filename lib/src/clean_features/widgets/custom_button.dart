import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String text;
  final double height;
  final VoidCallback onTap;
  final FocusNode? focusNode;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.focusNode,
    this.height = 60
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return FilledButton(
      focusNode: focusNode,
      onPressed: onTap,
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: Size.fromHeight(height)
      ),
      child: Text(text, style: textTheme.bodyMedium?.copyWith(color: Colors.white),)
    );
  }
}
