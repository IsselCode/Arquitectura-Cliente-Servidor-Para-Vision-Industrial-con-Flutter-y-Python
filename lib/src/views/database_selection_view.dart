import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/core/services/navigation_service.dart';
import 'package:arquitectura_cliente_sistema_vision/core/services/toast_service.dart';
import 'package:arquitectura_cliente_sistema_vision/inject_container.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/dialogs/add_db_dialog.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/dialogs/config_eval_dialog.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/dialogs/delete_db_dialog.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/ctrl_response.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/database_entity.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/action_box.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_carousel.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_shimmer.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/text_back_button.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/database_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/config_machine_view.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/eval_view.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';


class DatabaseSelectionView extends StatefulWidget {
  const DatabaseSelectionView({super.key});

  @override
  State<DatabaseSelectionView> createState() => _DatabaseSelectionViewState();
}

class _DatabaseSelectionViewState extends State<DatabaseSelectionView> {

  late Future<CtrlResponse> _loadDatabases;

  @override
  void initState() {
    super.initState();
    DatabaseController databaseController = context.read();
    _loadDatabases = databaseController.loadDatabases();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: createNewDatabase,
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


                  FutureBuilder(
                    future: _loadDatabases,
                    builder: (context, snapshot) {

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CustomShimmer(width: double.infinity, height: 300);
                      }

                      List<DatabaseEntity> databases = snapshot.data!.element;

                      return CustomCarousel(
                        height: 300,
                        itemCount: databases.length,
                        onChanged: (i) => debugPrint('Seleccionado: $i'),
                        itemBuilder: (context, index, isSelected) {
                          DatabaseEntity databaseEntity = databases[index];

                          return GestureDetector(
                            onTap: () => debugPrint('Tap ${databaseEntity.name}'),
                            child: ActionBox(
                              asset: AppAssets.db,
                              title: databaseEntity.name,
                              height: 300,
                              width: 300,
                              onTap: () => onTapDatabase(databaseEntity),
                              onDeleteTap: isSelected ? () => onDeleteDatabase(context, databaseEntity) : null,
                              color: colorScheme.surface
                            ),
                          );
                        },
                      );

                    },
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void onTapDatabase(DatabaseEntity databaseEntity) async {
    ConfigEvalType? result = await showDialog(context: context, builder: (context) => ConfigEvalDialog());

    if (result == null) {
      return ;
    }

    NavigationService navigationService = locator();
    if (result == ConfigEvalType.config){
      navigationService.navigateTo(ConfigMachineView.init(databaseEntity));
    } else {
      navigationService.navigateTo(EvalView());
    }

  }

  void onDeleteDatabase(BuildContext context, DatabaseEntity databaseEntity) async {
    bool? result = await showDialog(context: context, builder: (context) => DeleteDBDialog(),);

    if (result != null && result) {
      DatabaseController databaseController = context.read();
      ToastService toastService = locator();

      context.loaderOverlay.show();
      CtrlResponse response = await databaseController.deleteDabatase(databaseEntity);
      context.loaderOverlay.hide();

      if (response.success) {
        toastService.success("Base de datos eliminada");
      } else {
        toastService.error(response.message!);
      }

    }

  }

  void createNewDatabase() async {

    String? result = await showDialog(
      context: context,
      builder: (context) => AddDBDialog()
    );

    if (result == null){
      return ;
    }

    DatabaseController databaseController = context.read();
    ToastService toastService = locator();
    context.loaderOverlay.show();
    CtrlResponse response = await databaseController.createDatabase(result);
    context.loaderOverlay.hide();
    if (response.success){
      toastService.success("Base de datos creada");
    } else {
      toastService.error(response.message!);
    }

  }

}
