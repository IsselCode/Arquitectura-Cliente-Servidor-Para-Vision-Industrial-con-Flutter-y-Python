import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/core/services/navigation_service.dart';
import 'package:arquitectura_cliente_sistema_vision/core/services/toast_service.dart';
import 'package:arquitectura_cliente_sistema_vision/inject_container.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/dialogs/add_db_dialog.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/dialogs/config_eval_dialog.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/dialogs/delete_db_dialog.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/config_entity.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/ctrl_response.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/config_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/config_machine_view.dart';
import 'package:arquitectura_cliente_sistema_vision/src/views/eval_view.dart';
import 'package:flutter/material.dart';
import 'package:issel_code_widgets/issel_code_widgets.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class DatabaseSelectionView extends StatefulWidget {
  const DatabaseSelectionView({super.key});

  @override
  State<DatabaseSelectionView> createState() => _DatabaseSelectionViewState();
}

class _DatabaseSelectionViewState extends State<DatabaseSelectionView> {
  late Future<CtrlResponse<List<ConfigEntity>>> _loadDatabases;

  @override
  void initState() {
    super.initState();
    ConfigController databaseController = context.read();
    _loadDatabases = databaseController.loadDatabases();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    ConfigController configController = context.watch();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: createNewDatabase,
        child: Icon(Icons.add_outlined),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 100,
            children: [
              Text("Selecciona una configuracion", style: textTheme.displayLarge),
              FutureBuilder<CtrlResponse<List<ConfigEntity>>>(
                future: _loadDatabases,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return IsselShimmer(width: double.infinity, height: 300);
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error al cargar configuraciones"),
                    );
                  }

                  final response = snapshot.data;
                  if (response == null) {
                    return Center(child: Text("Sin datos"));
                  }

                  if (!response.success) {
                    return Center(
                      child: Text(
                        response.message ?? "Error al cargar configuraciones",
                      ),
                    );
                  }

                  final List<ConfigEntity> configs = configController.configs;
                  if (configs.isEmpty) {
                    return Center(
                      child: Text("No hay configuraciones disponibles"),
                    );
                  }

                  return IsselCarousel(
                    height: 300,
                    itemCount: configs.length,
                    onChanged: (i) => debugPrint('Seleccionado: $i'),
                    itemBuilder: (context, index, isSelected) {
                      final ConfigEntity configEntity = configs[index];
                      return IsselActionBox(
                        asset: AppAssets.db,
                        title: configEntity.dpName,
                        height: 300,
                        width: double.infinity,
                        onTap: () => onTapDatabase(configEntity),
                        onDeleteTap: isSelected ? () => onDeleteDatabase(context, configEntity) : null,
                        color: colorScheme.surface,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapDatabase(ConfigEntity configEntity) async {
    ConfigEvalType? result = await showDialog(
      context: context,
      builder: (context) => ConfigEvalDialog(),
    );

    if (result == null) {
      return;
    }

    NavigationService navigationService = locator();
    if (result == ConfigEvalType.config) {
      navigationService.navigateTo(ConfigMachineView.init(configEntity));
    } else {
      navigationService.navigateTo(EvalView());
    }
  }

  void onDeleteDatabase(BuildContext context, ConfigEntity databaseEntity) async {
    bool? result = await showDialog(
      context: context,
      builder: (context) => DeleteDBDialog(),
    );

    if (result != null && result) {
      ConfigController databaseController = context.read();
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
      builder: (context) => AddDBDialog(),
    );

    if (result == null) {
      return;
    }

    ConfigController databaseController = context.read();
    ToastService toastService = locator();
    context.loaderOverlay.show();
    CtrlResponse response = await databaseController.createDatabase(result);
    context.loaderOverlay.hide();
    if (response.success) {
      toastService.success("Base de datos creada");
    } else {
      toastService.error(response.message!);
    }
  }
}
