import 'package:flutter/material.dart';

class AssetContainer extends StatelessWidget {

  final double height;
  final double width;
  final String asset;

  const AssetContainer({
    super.key,
    required this.asset,
    this.height = 80,
    this.width = 80
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: colorScheme.onSurface.withAlpha(60)
          )
        ]
      ),
      padding: const EdgeInsets.all(10.0),
      child: Image.asset(asset, fit: BoxFit.contain,),
    );
  }
}
