import 'package:flutter/material.dart';

import '../../../core/app/consts.dart';

enum CustomWidgetAlignStates {
  left,
  right
}

class CustomWidget extends StatefulWidget {

  final double height;
  final String leftText;
  final String rightText;
  final ValueChanged<CustomWidgetAlignStates> state;
  final Color? color;

  const CustomWidget({
    super.key,
    required this.leftText,
    required this.rightText,
    required this.state,
    this.height = 50,
    this.color,
  });

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> with SingleTickerProviderStateMixin {

  CustomWidgetAlignStates alignState = CustomWidgetAlignStates.left;

  void _toggleMovement() {

    if (isLeftAlign()) {
      alignState = CustomWidgetAlignStates.right;
    } else {
      alignState = CustomWidgetAlignStates.left;
    }

    widget.state.call(alignState);
    setState(() {});
  }

  bool isLeftAlign() => alignState == CustomWidgetAlignStates.left;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorScheme colorScheme = theme.colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => _toggleMovement(),
      child: Ink(
        height: widget.height,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: widget.color ?? colorScheme.surface,
          borderRadius: BorderRadius.circular(10)
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [

                // Selected
                AnimatedAlign(
                  duration: Duration(milliseconds: 250),
                  alignment: isLeftAlign() ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    width: constraints.maxWidth / 2,
                    decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(10)
                    ),

                  ),
                ),

                // Button Texts
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          widget.leftText,
                          style: textTheme.bodyMedium?.copyWith(
                            color: isLeftAlign() ? null : AppColors.grey,
                            fontWeight: isLeftAlign() ? FontWeight.bold : FontWeight.normal
                          ),
                        )
                      )
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          widget.rightText,
                          style: textTheme.bodyMedium?.copyWith(
                            color: isLeftAlign() ? AppColors.grey : null,
                            fontWeight: isLeftAlign() ? FontWeight.normal : FontWeight.bold,
                          ),
                        )
                      )
                    ),
                  ],
                ),


              ],


            );
          },
        ),
      ),
    );
  }
}
