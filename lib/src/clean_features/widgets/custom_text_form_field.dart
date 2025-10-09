import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends FormField<String> {
  final TextEditingController? controller;
  final bool autofocus;
  final FocusNode? focusNode;
  final String hintText;
  final Color? fillColor;
  final bool obscureText;
  final IconData prefixIcon;
  final double height;

  CustomTextFormField({
    super.key,
    this.controller,
    this.autofocus = false,
    this.focusNode,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.fillColor,
    this.height = 60,
    FormFieldValidator<String>? validator,
    AutovalidateMode? autovalidateMode,
  }) : super(
    validator: validator,
    autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
    builder: (state) {
      final theme = Theme.of(state.context);
      final textTheme = theme.textTheme;
      final colorScheme = theme.colorScheme;

      final s = state as _CustomTextFormFieldState;

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: height,
            decoration: BoxDecoration(
              color: fillColor ?? colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            // Layout manual para evitar expansión del InputDecorator
            child: Row(
              children: [
                const SizedBox(width: 8),
                Icon(prefixIcon, color: AppColors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: controller,
                    autofocus: autofocus,
                    focusNode: focusNode,
                    obscureText: obscureText && s.showPassword,
                    onChanged: state.didChange, // integra con el Form
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration.collapsed(
                      hintText: hintText,
                      hintStyle: textTheme.bodyMedium?.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ),
                if (obscureText)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: IconButton(
                      constraints: BoxConstraints(maxWidth: 48, maxHeight: 48),
                      onPressed: () => state.setState(() {s.showPassword = !s.showPassword;}),
                      icon: const Icon(Icons.remove_red_eye_outlined, color: AppColors.grey,),
                    ),
                  ),
                // const SizedBox(width: 8),
              ],
            ),
          ),

          // 👇 El error va DEBAJO del contenedor, no dentro del TextField
          if (state.hasError)
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 12),
              child: Text(
                state.errorText!,
                style: TextStyle(
                  color: theme.colorScheme.error,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      );
    },
  );

  @override
  FormFieldState<String> createState() => _CustomTextFormFieldState();

}

class _CustomTextFormFieldState extends FormFieldState<String> {
  bool showPassword = false;
}
