import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_button.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_dropdown.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/float_on_tap_text_field.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/header_action_tile.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/info_field.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/stepper_field.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/tab_switcher.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/toggle_field.dart';
import 'package:flutter/material.dart';

class ConfigMachineView extends StatefulWidget {
  const ConfigMachineView({super.key});

  @override
  State<ConfigMachineView> createState() => _ConfigMachineViewState();
}

class _ConfigMachineViewState extends State<ConfigMachineView> {
  
  PageController pageController = PageController(initialPage: 0);
  TabSwitcherAlignStates tabState = TabSwitcherAlignStates.left;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Row(
            spacing: 50,
            children: [
              //! Left Panel
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
                          _leftPanel(),
                          Container(),
                          _rightPanel()
                        ],
                      ),
                    )
                    
                  ],
                ),
              ),

              //! Right Panel
              Expanded(
                child: Container(
                  color: Colors.blue,
                ),
              )
            ],
          ),
        )
      ),
    );
  }
  
  
  Widget _leftPanel() {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorScheme colorScheme = theme.colorScheme;
    
    return SingleChildScrollView(
      child: Flex(
        direction: Axis.vertical,
        spacing: 10,
        children: [
          //* Dirección del PLC
          Flex(
            spacing: 10,
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Dirección IP del PLC", style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
              FloatOnTapTextField(
                  height: 50,
                  controller: TextEditingController(),
                  hintText: "192.168.x.y:0000",
                  prefixIcon: Icons.lock_outline
              ),
              CustomButton(
                text: "Asignar",
                onTap: () => print("Asignando"),
              )
            ],
          ),
          Divider(color: AppColors.grey,),
      
          //* Salidas
          Flex(
            direction: Axis.vertical,
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Dirección IP del PLC", style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
              HeaderActionTile(
                textButton: "Probar",
                title: "Iluminación Q1",
                subTitle: "Salida",
                onPressed: () => print("Probando Iluminación Q1"),
              ),
              HeaderActionTile(
                textButton: "Probar",
                title: "Señal Ok",
                subTitle: "Salida",
                onPressed: () => print("Probando Señal Ok"),
              ),
              HeaderActionTile(
                textButton: "Probar",
                title: "Señal NG",
                subTitle: "Salida",
                onPressed: () => print("Probando Señal NG"),
              )
            ],
          ),
          Divider(color: AppColors.grey,),
      
          //* Contadores
          Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 10,
            children: [
              InfoField(title: "Piezas Ok", value: "1"),
              InfoField(title: "Piezas NG", value: "1"),
              CustomButton(
                text: "Reiniciar Contadores",
                color: Colors.red,
                onTap: () => print("Reiniciando Contadores"),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _rightPanel() {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorScheme colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      child: Flex(
        direction: Axis.vertical,
        spacing: 10,
        children: [
          //* Configurar Vistas
          Flex(
            spacing: 10,
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Configurar Vistas", style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
              CustomDropdown<int>(
                items: List.generate(5, (index) {
                  return DropdownMenuItem(
                    value: index,
                    child: Text(index.toString()),
                  );
                },),
                hintText: "Cámara",
                onChanged: (p0) {
                  print(p0);
                },
              ),
              StepperField(
                title: "Exposición",
                minValue: 0,
                maxValue: 100,
                onChanged: (value) {

                },
              ),
              ToggleField(
                title: "Luz",
                value: false,
                onChanged: (value) {

                },
              )
            ],
          ),
          Divider(color: AppColors.grey,),

          //* Salidas
          Flex(
            direction: Axis.vertical,
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Herramientas", style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
                  IconButton(
                    onPressed: () => print("Añadir herramienta"),
                    style: IconButton.styleFrom(
                      backgroundColor: colorScheme.surface,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                    ),
                    icon: Icon(Icons.add_outlined)
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
  
}
