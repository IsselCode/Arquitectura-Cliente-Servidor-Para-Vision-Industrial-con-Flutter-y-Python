import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends FormField<String> {
  final TextEditingController? controller;
  final bool autofocus;
  final FocusNode? focusNode;
  final String hintText;
  final Color? fillColor;
  final bool obscureText;
  final IconData prefixIcon;
  final double height;
  final bool readOnly;
  final VoidCallback? onTap;
  final void Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;

  CustomTextFormField({
    super.key,
    this.controller,
    this.onSubmitted,
    this.onTap,
    this.inputFormatters,
    this.readOnly = false,
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

      final ctrl = controller ?? TextEditingController(text: state.value ?? '');
      ctrl.addListener(() {
        if (state.value != ctrl.text) {
          state.didChange(ctrl.text);
        }
      });

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(state.context).requestFocus(s._focusNode);
              onTap?.call();
            },
            child: Container(
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
                      inputFormatters: inputFormatters,
                      onSubmitted: onSubmitted,
                      onTap: onTap,
                      readOnly: readOnly,
                      controller: controller,
                      autofocus: autofocus,
                      focusNode: s._focusNode,
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
  bool showPassword = true;
  late FocusNode _focusNode;

  @override
  CustomTextFormField get widget => super.widget as CustomTextFormField;

  @override
  void initState() {
    super.initState();
    // FocusNode: usar el externo o crear uno propio
    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
    } else {
      _focusNode = FocusNode();
    }
  }

}
