import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/asset_container.dart';
import 'package:flutter/material.dart';

class ShowWidgetsView extends StatelessWidget {
  const ShowWidgetsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            AssetContainer(asset: "assets/logo.png")

          ],
        ),
      ),
    );
  }
}
