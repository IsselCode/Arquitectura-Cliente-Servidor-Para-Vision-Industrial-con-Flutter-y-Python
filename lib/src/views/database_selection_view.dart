import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/dialogs/add_db_dialog.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/dialogs/config_eval_dialog.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/dialogs/delete_db_dialog.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/action_box.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_carousel.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/text_back_button.dart';
import 'package:flutter/material.dart';


class DatabaseSelectionView extends StatelessWidget {
  const DatabaseSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          String? result = await showDialog(
            context: context,
            builder: (context) => AddDBDialog()
          );

          print(result);

        },
        child: Icon(Icons.add_outlined),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Stack(
            children: [
              TextBackButton(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 100,
                children: [
                  Text("Selecciona una base de datos", style: textTheme.displayLarge),

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
                        child: ActionBox(
                            asset: AppAssets.db,
                            title: "index ${index}",
                            height: 300,
                            width: 300,
                            onTap: () => showDialog(context: context, builder: (context) => ConfigEvalDialog(),),
                            onDeleteTap: isSelected ? () async {
                              bool? result = await showDialog(
                                context: context,
                                builder: (context) => DeleteDBDialog(),
                              );

                              print(result);
                            } : null,
                            color: colorScheme.surface
                        ),
                      );
                    },
                  )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
