import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StepperField extends StatefulWidget {

  final int initValue;
  final String title;
  final double height;
  final Color? backColor;
  final Color? counterColor;
  final int maxValue;
  final int minValue;
  final ValueChanged<int> onChanged;

  StepperField({
    super.key,
    required this.title,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
    this.initValue = 0,
    this.height = 50,
    this.backColor,
    this.counterColor
  }) : assert(minValue <= maxValue, 'minValue debe ser <= maxValue');

  @override
  State<StepperField> createState() => _StepperFieldState();
}

class _StepperFieldState extends State<StepperField> {

  @override
  void initState() {
    super.initState();
    delta.text = widget.initValue.toString();
    oldDelta = widget.initValue;
  }

  @override
  void dispose() {
    super.dispose();
    delta.dispose();
  }

  late int oldDelta;
  final TextEditingController delta = TextEditingController();

  void toggleDelta(int value) {
    if (delta.text.isEmpty || (delta.text.length == 1 && delta.text.contains("-"))){
     delta.text = oldDelta.toString();
    }
    int tempValue = int.parse(delta.text);
    tempValue += value;
    int resultado = tempValue.clamp(widget.minValue, widget.maxValue);
    delta.text = resultado.toString();
    oldDelta = resultado;
    widget.onChanged.call(int.parse(delta.text));
    setState(() {});
  }

  void onChanged(String value) {
    if (value.isEmpty || (value.length == 1 && value.contains("-"))) return;
    int tempValue = int.parse(delta.text);
    int resultado = tempValue.clamp(widget.minValue, widget.maxValue);
    delta.text = resultado.toString();
    oldDelta = resultado;
    widget.onChanged.call(int.parse(delta.text));
    setState(() {});
  }

  void onSubmitted(String value) {
    if (delta.text.isEmpty || (delta.text.length == 1 && delta.text.contains("-"))){
      delta.text = oldDelta.toString();
    }
    widget.onChanged.call(int.parse(delta.text));
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;

    return Container(
      height: widget.height,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: widget.backColor ?? colorScheme.surface,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          // Text
          Expanded(
            child: Text(
              widget.title
            )
          ),

          // Counter
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: widget.counterColor ?? theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => toggleDelta(-1),
                    icon: Icon(Icons.remove_outlined)
                  ),
                  Expanded(
                    child: TextField(
                      controller: delta,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      onSubmitted: onSubmitted,
                      onChanged: onChanged,
                      keyboardType: TextInputType.numberWithOptions(signed: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r"^-?\d*$")
                        ),
                      ],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: oldDelta.toString(),
                        hintStyle: textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                        isCollapsed: true,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => toggleDelta(1),
                    icon: Icon(Icons.add_outlined)
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}
