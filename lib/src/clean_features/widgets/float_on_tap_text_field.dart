import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'custom_text_form_field.dart';

class FloatOnTapTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final Color? fillColor;
  final double height;

  const FloatOnTapTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.fillColor,
    this.height = 60,
  });

  @override
  State<FloatOnTapTextField> createState() => _FloatOnTapTextFieldState();
}

class _FloatOnTapTextFieldState extends State<FloatOnTapTextField> {
  final Object _heroTag = Object();

  Future<void> _openOverlay() async {
    final result = await Navigator.of(context).push<_FloatResult>(
      PageRouteBuilder<_FloatResult>(
        opaque: false,
        barrierColor: Colors.black26,
        transitionDuration: const Duration(milliseconds: 250),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, anim, _) {
          return _FloatingEditorRoute(
            heroTag: _heroTag,
            controllerText: widget.controller.text,
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon,
            obscureText: widget.obscureText,
            fillColor: widget.fillColor,
            height: widget.height,
          );
        },
        transitionsBuilder: (context, anim, _, child) {
          return FadeTransition(
            opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
            child: child,
          );
        },
      ),
    );

    if (result != null && result.accepted) {
      widget.controller.text = result.text;
      widget.controller.selection = TextSelection.collapsed(offset: result.text.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: _heroTag,
      flightShuttleBuilder: (ctx, anim, dir, fromCtx, toCtx) {
        return Material(
          type: MaterialType.transparency,
          child: dir == HeroFlightDirection.push ? fromCtx.widget : toCtx.widget,
        );
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _openOverlay,
        child: ExcludeFocus(
          child: CustomTextFormField(
            controller: widget.controller,
            onTap: _openOverlay,
            readOnly: true,
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon,
            fillColor: widget.fillColor,
            obscureText: widget.obscureText,
          )
        ),
      ),
    );
  }
}



class _FloatingEditorRoute extends StatefulWidget {
  final Object heroTag;
  final String controllerText;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final Color? fillColor;
  final double height;

  const _FloatingEditorRoute({
    required this.heroTag,
    required this.controllerText,
    required this.hintText,
    required this.prefixIcon,
    required this.obscureText,
    required this.fillColor,
    required this.height,
  });

  @override
  State<_FloatingEditorRoute> createState() => _FloatingEditorRouteState();
}

class _FloatingEditorRouteState extends State<_FloatingEditorRoute> {
  late final TextEditingController _controller =
  TextEditingController(text: widget.controllerText);
  late final FocusNode _focusNode = FocusNode();
  bool _focusedOnce = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Pide foco SOLO cuando la transición del route ha COMPLETADO (Hero listo)
    final anim = ModalRoute.of(context)?.animation;
    anim?.addStatusListener((status) {
      if (status == AnimationStatus.completed && !_focusedOnce) {
        _focusedOnce = true;
        _focusNode.requestFocus(); // 👈 abre el teclado una sola vez
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  Rect _availableRect(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;
    final top = mq.viewPadding.top;
    final bottomInset = mq.viewInsets.bottom;
    final height = size.height - bottomInset - top;
    return Rect.fromLTWH(0, top, size.width, height);
  }

  double _targetWidth(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return math.min(w - 32, 640);
  }

  @override
  Widget build(BuildContext context) {
    final avail = _availableRect(context);
    final fieldHeight = widget.height + 8;
    final targetW = _targetWidth(context);
    final left = (avail.width - targetW) / 2;
    final top = avail.top + (avail.height - fieldHeight) / 2;

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(_FloatResult.cancel()),
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          children: [
            Positioned.fill(child: Container(color: Colors.transparent)),
            Positioned(
              top: top,
              left: left,
              width: targetW,
              child: Hero(
                tag: widget.heroTag,
                child: CustomTextFormField(
                  controller: _controller,
                  hintText: widget.hintText,
                  prefixIcon: widget.prefixIcon,
                  focusNode: _focusNode,
                  onSubmitted: (_) => Navigator.of(context).pop(_FloatResult.ok(_controller.text)),
                  obscureText: widget.obscureText,
                  readOnly: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class _FloatResult {
  final bool accepted;
  final String text;
  _FloatResult(this.accepted, this.text);
  factory _FloatResult.ok(String text) => _FloatResult(true, text);
  factory _FloatResult.cancel() => _FloatResult(false, '');
}
