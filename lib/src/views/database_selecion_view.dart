import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_carousel.dart';
import 'package:flutter/material.dart';


class DatabaseSelecionView extends StatelessWidget {
  const DatabaseSelecionView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 100,
            children: [
              Text("¿Qué quieres hacer hoy?", style: textTheme.displayLarge),

            // En tu build:
            CustomCarousel(
              height: 300,
              itemCount: 5,
              initialIndex: 2,
              viewportFraction: 0.25,
              selectedScale: 1.0,
              unselectedScale: 2/3,
              onChanged: (i) => debugPrint('Seleccionado: $i'),
              itemBuilder: (context, index, isSelected) {
                return GestureDetector(
                  onTap: () => debugPrint('Tap $index'),
                  child: _ActionBox(
                    image: AppAssets.db,
                    text: "index",
                    onTap: () {
                      print(index);
                    },
                    color: colorScheme.surface
                  ),
                );
              },
            )

            ],
          ),
        ),
      ),
    );
  }
}

class _ActionBox extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onTap;
  final Color color;

  const _ActionBox({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      child: InkResponse(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          padding: const EdgeInsets.all(20),
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 40,
            children: [
              Image.asset(image, height: 128, width: 128),
              SizedBox(
                height: 70,
                child: Center(
                  child: Text(
                    text,
                    style: textTheme.titleLarge,
                    textAlign: TextAlign.center,
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
