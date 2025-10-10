import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/radio_card.dart';
import 'package:flutter/material.dart';

class ChoiceCardGroup<T> extends StatelessWidget {

  final T? value;
  final ValueChanged<T>? onChanged; // ← callback
  final double size;
  final List<RadioCard<T>> children;

  const ChoiceCardGroup({
    super.key,
    this.value,
    required this.onChanged,
    required this.size,
    required this.children
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children.map((c) {
        return RadioCard<T>(
          // props originales del hijo
          value: c.value,
          label: c.label,
          asset: c.asset,
          size: size,
          surfaceColor: c.surfaceColor,
          // inyección del estado de grupo
          groupValue: value,
          onChanged: onChanged,
        );
      }).toList(),
    );
  }
}
