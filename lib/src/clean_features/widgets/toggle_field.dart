import 'package:flutter/material.dart';

class ToggleField extends StatelessWidget {

  final bool value;
  final String title;
  final double height;
  final double width;
  final Color? backColor;
  final ValueChanged<bool> onChanged;

  const ToggleField({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.height = 50,
    this.width = 60,
    this.backColor,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;

    final double switchHeight = height * 0.65;
    final double thumbMargin = 4;
    final double thumbSize = switchHeight - thumbMargin * 2;

    return Container(
      height: height,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: backColor ?? colorScheme.surface,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          // Text
          Expanded(
            child: Text(
                title
            )
          ),

          // Switch
          InkWell(
            onTap: () => onChanged(!value),
            child: Container(
              height: switchHeight,
              width: width,
              padding: EdgeInsets.all(thumbMargin),
              decoration: BoxDecoration(
                color: backColor ?? theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(height * 0.5)
              ),
              child: AnimatedAlign(
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                duration: const Duration(milliseconds: 200),
                curve: Curves.fastOutSlowIn,
                child: Container(
                  height: thumbSize,
                  width: thumbSize,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
