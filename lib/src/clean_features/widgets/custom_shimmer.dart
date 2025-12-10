import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// [delay] 50ms default
class CustomShimmer extends StatefulWidget {

  final double width;
  final double height;
  final Duration delay;

  const CustomShimmer({
    super.key,
    required this.width,
    required this.height,
    this.delay = const Duration(milliseconds: 50)
  });

  @override
  State<CustomShimmer> createState() => _CustomShimmerState();
}

class _CustomShimmerState extends State<CustomShimmer> {

  bool show = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(widget.delay, () {
      if (mounted) setState(() => show = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return show ? Shimmer.fromColors(
        baseColor: const Color(0xffcfcfcf).withAlpha(150),
        highlightColor: const Color(0xffcfcfcf).withAlpha(50),
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
        )
    ) : SizedBox.shrink();
  }
}
