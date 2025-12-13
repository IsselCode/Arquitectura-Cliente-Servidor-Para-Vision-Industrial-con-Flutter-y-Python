import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/dialogs/add_new_tool_dialog.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_button.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_dropdown.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/float_on_tap_text_field.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/header_action_tile.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/info_field.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/stepper_field.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/tab_switcher.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/text_back_button.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/toggle_field.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/ui/config_machine_ctrl.dart';
import 'package:arquitectura_cliente_sistema_vision/src/pages/config_machine/machine_page.dart';
import 'package:arquitectura_cliente_sistema_vision/src/pages/config_machine/tools_page.dart';
import 'package:bbox_editor/bbox_editor.dart';
import 'package:bbox_editor/exports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfigMachineView extends StatefulWidget {

  const ConfigMachineView._();

  static Widget init() {
    return ChangeNotifierProvider(
      create: (context) => ConfigMachineCtrl(cameraController: context.read()),
      builder: (context, child) => ConfigMachineView._(),
    );
  }

  @override
  State<ConfigMachineView> createState() => _ConfigMachineViewState();
}

class _ConfigMachineViewState extends State<ConfigMachineView>  {
  
  PageController pageController = PageController(initialPage: 0);
  TabSwitcherAlignStates tabState = TabSwitcherAlignStates.left;


  late Future<void> _startFuture;
  @override
  void initState() {
    super.initState();
    ConfigMachineCtrl configMachineCtrl = context.read();
    _startFuture = configMachineCtrl.loadInitialData();
  }

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
                    TabSwitcher(
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
                    FutureBuilder(
                      future: _startFuture,
                      builder: (context, snapshot) {

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator(),);
                        }

                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Stack(
                              children: [

                                BBoxEditor(
                                  camResolution: Size(1920, 1080),
                                  controller: configMachineCtrl.bBoxEditorController,
                                  logs: false,
                                  image: configMachineCtrl.image,
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
                        );

                      },
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
