import 'package:animated_counter_x/animated_counter_x.dart';
import 'package:flutter/material.dart';

class ScanPulseButton extends StatefulWidget {
  final double size;
  final Color avatarColor;
  final String image;
  final Color? ring1Color;
  final Color? ring2Color;
  final Duration period;
  final bool active;
  final int quantity;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final TextStyle? textStyle;

  final VoidCallback? onTap;

  const ScanPulseButton({
    super.key,
    this.size = 96,
    required this.avatarColor,
    this.textStyle,
    required this.image,
    this.ring1Color,
    this.ring2Color,
    this.period = const Duration(milliseconds: 1600),
    this.active = true,
    required this.quantity,
    this.transitionDuration = const Duration(milliseconds: 260),
    this.transitionCurve = Curves.easeInOut,
    this.onTap,
  });

  @override
  State<ScanPulseButton> createState() => _ScanPulseButtonState();
}

class _ScanPulseButtonState extends State<ScanPulseButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctl;
  late final Animation<double> _a; // 0..1

  Color _lighten(Color c, double amount) {
    final hsl = HSLColor.fromColor(c);
    final l = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(l).toColor();
  }

  @override
  void initState() {
    super.initState();
    _ctl = AnimationController(vsync: this, duration: widget.period);
    _a = CurvedAnimation(parent: _ctl, curve: Curves.easeInOut);
    _syncAnimationWithActive();
  }

  @override
  void didUpdateWidget(covariant ScanPulseButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.active != widget.active || oldWidget.period != widget.period) {
      _ctl.duration = widget.period;
      _syncAnimationWithActive();
    }
  }

  void _syncAnimationWithActive() {
    if (widget.active) {
      if (!_ctl.isAnimating) _ctl.repeat();
    } else {
      _ctl.stop();
    }
  }

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ring1 = widget.ring1Color ?? _lighten(widget.avatarColor, 0.18);
    final ring2 = widget.ring2Color ?? _lighten(widget.avatarColor, 0.30);

    final d = widget.size;
    final avatarDiameter = d * 0.65;

    return Semantics(
      button: true,
      label: widget.active ? 'Scan activo' : 'Scan inactivo',
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: d,
          height: d,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Ondas SOLO si está activo
              if (widget.active)
                AnimatedBuilder(
                  animation: _a,
                  builder: (_, __) {
                    final t1 = _a.value;
                    final t2 = (t1 + 0.5) % 1.0;
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        _Ripple(progress: t2, color: ring2, maxDiameter: d),
                        _Ripple(progress: t1, color: ring1, maxDiameter: d * 0.86),
                      ],
                    );
                  },
                ),

              // Circle avatar frontal (contenido cambia con animaciones)
              Container(
                width: avatarDiameter,
                height: avatarDiameter,
                decoration: BoxDecoration(
                  color: widget.avatarColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 16,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                      color: widget.avatarColor.withOpacity(0.35),
                    ),
                  ],
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: widget.transitionDuration,
                    switchInCurve: widget.transitionCurve,
                    switchOutCurve: widget.transitionCurve,
                    layoutBuilder: (currentChild, previousChildren) => Stack(
                      alignment: Alignment.center,
                      children: <Widget>[...previousChildren, if (currentChild != null) currentChild,],
                    ),
                    child: widget.active
                      ? _ActiveIcon(
                        key: const ValueKey('active'),
                        image: widget.image,
                        size: avatarDiameter * 0.42,
                        duration: widget.transitionDuration,
                        curve: widget.transitionCurve,
                      )
                      : _InactiveIconWithLabel(
                        key: const ValueKey('inactive'),
                        image: widget.image,
                        iconSize: avatarDiameter * 0.45, // más chico
                        quantity: widget.quantity,
                        textStyle: widget.textStyle,
                        duration: widget.transitionDuration,
                        curve: widget.transitionCurve,
                      ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActiveIcon extends StatelessWidget {
  final String image;
  final double size;
  final Duration duration;
  final Curve curve;

  const _ActiveIcon({
    super.key,
    required this.image,
    required this.size,
    required this.duration,
    required this.curve,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: size),
      duration: duration,
      curve: curve,
      builder: (_, v, __) => Image.asset(image, height: v, width: v,),
    );
  }
}

class _InactiveIconWithLabel extends StatelessWidget {
  final String image;
  final double iconSize;
  final int quantity;
  final TextStyle? textStyle;
  final Duration duration;
  final Curve curve;

  const _InactiveIconWithLabel({
    super.key,
    required this.iconSize,
    required this.quantity,
    this.textStyle,
    required this.duration,
    required this.curve,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: duration,
      curve: curve,
      child: Column(
        key: ValueKey(quantity),
        mainAxisSize: MainAxisSize.min,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(end: iconSize),
            duration: duration,
            curve: curve,
            builder: (_, v, __) => Image.asset(image, height: v, width: v,),
          ),
          SizedBox(height: 10),
          AnimatedCounterX(
            end: quantity,
            style: textStyle,
            duration: Duration(seconds: 1),
          )
        ],
      ),
    );
  }
}

class _Ripple extends StatelessWidget {
  final double progress; // 0..1
  final Color color;
  final double maxDiameter;

  const _Ripple({
    required this.progress,
    required this.color,
    required this.maxDiameter,
  });

  @override
  Widget build(BuildContext context) {
    final scale = 0.55 + 0.45 * progress;
    final opacity = (1.0 - progress) * 0.55;

    return Opacity(
      opacity: opacity.clamp(0.0, 1.0),
      child: Container(
        width: maxDiameter * scale,
        height: maxDiameter * scale,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
