import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/config_entity.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/text_back_button.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/ui/config_machine_ctrl.dart';
import 'package:arquitectura_cliente_sistema_vision/src/pages/config_machine/machine_page.dart';
import 'package:arquitectura_cliente_sistema_vision/src/pages/config_machine/tools_page.dart';
import 'package:bbox_editor/bbox_editor.dart';
import 'package:bbox_editor/exports.dart';
import 'package:flutter/material.dart';
import 'package:issel_code_widgets/issel_code_widgets.dart';
import 'package:provider/provider.dart';

import '../../inject_container.dart';

class ConfigMachineView extends StatefulWidget {

  const ConfigMachineView._();

  static Widget init(ConfigEntity database) {
    return ChangeNotifierProvider(
      create: (context) => ConfigMachineCtrl(toastService: locator(), database: database, context: context, databaseController: context.read()),
      builder: (context, child) => ConfigMachineView._(),
    );
  }

  @override
  State<ConfigMachineView> createState() => _ConfigMachineViewState();
}

class _ConfigMachineViewState extends State<ConfigMachineView>  {
  
  PageController pageController = PageController(initialPage: 0);
  TabSwitcherAlignStates tabState = TabSwitcherAlignStates.left;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorScheme colorScheme = theme.colorScheme;

    ConfigMachineCtrl configMachineCtrl = context.watch();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Row(
            spacing: 50,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! Side panel
              SizedBox(
                width: 300,
                child: Column(
                  spacing: 10,
                  children: [
                    //* Pestañas
                    IsselTabSwitcher(
                      leftText: "Maquina",
                      rightText: "Herramienta",
                      state: tabState,
                      onChanged: (value) {
                        if (value == TabSwitcherAlignStates.left) {
                          pageController.animateToPage(0, duration: Duration(milliseconds: 250), curve: Curves.fastOutSlowIn);
                        } else {
                          pageController.animateToPage(2, duration: Duration(milliseconds: 250), curve: Curves.fastOutSlowIn);
                        }
                        tabState = value;
                        setState(() {});
                      },
                    ),
                    Divider(color: AppColors.grey,),

                    //! PageViewPanel
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          MachinePage(),
                          Container(),
                          ToolsPage()
                        ],
                      ),
                    )

                  ],
                ),
              ),

              //! Right Panel
              Expanded(
                child: Stack(
                  children: [
                    TextBackButton(),

                    Center(
                      child: AspectRatio(
                        aspectRatio: 16/9,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: configMachineCtrl.database.imgMaestra == null ? () => configMachineCtrl.captureMasterImage(false) : null,
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: colorScheme.surface,
                            ),
                            child: Stack(
                              children: [

                                if (configMachineCtrl.database.imgMaestra == null)
                                  Center(
                                    child: Text(
                                      "Capturar imagen maestra",
                                      style: textTheme.titleLarge,
                                    )
                                  ),

                                if (configMachineCtrl.database.imgMaestra != null)
                                  BBoxEditor(
                                    camResolution: Size(1920, 1080),
                                    controller: configMachineCtrl.bBoxEditorController,
                                    logs: false,
                                    image: NetworkImage("https://i.ibb.co/B2Fy6SVC/prueba.jpg"),
                                  ),

                                if (configMachineCtrl.database.imgMaestra != null)
                                  Positioned(
                                    left: 10,
                                    bottom: 10,
                                    child: Tooltip(
                                      message: "Capturar nueva imagen maestra",
                                      child: FloatingActionButton(
                                        onPressed: () => configMachineCtrl.captureMasterImage(true),
                                        child: Icon(Icons.camera_outlined)
                                      ),
                                    ),
                                  ),

                                Positioned(
                                  right: 10,
                                  bottom: 10,
                                  child: FloatingActionButton(
                                    onPressed: () async {
                                      if (configMachineCtrl.bBoxEditorController.bBoxTool.value == BBoxTool.zoom){
                                        configMachineCtrl.bBoxEditorController.setTool(BBoxTool.bboxs);
                                      } else {
                                        configMachineCtrl.bBoxEditorController.setTool(BBoxTool.zoom);
                                      }
                                      setState(() {});
                                    },
                                    child: Icon(configMachineCtrl.bBoxEditorController.bBoxTool.value == BBoxTool.zoom ? Icons.zoom_out_map_outlined : Icons.edit_outlined),
                                  ),
                                )

                              ],
                            ),
                          ),
                        ),
                      )
                    )

                  ],
                ),
              )
            ],
          ),
        )
      ),
    );

  }
  
}
