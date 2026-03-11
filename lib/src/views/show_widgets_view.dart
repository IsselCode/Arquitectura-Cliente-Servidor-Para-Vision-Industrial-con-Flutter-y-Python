import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:flutter/material.dart';
import 'package:issel_code_widgets/issel_code_widgets.dart';


enum Role {
  admin,
  calidad,
  tecnico
}

class ShowWidgetsView extends StatefulWidget {
  const ShowWidgetsView({super.key});

  @override
  State<ShowWidgetsView> createState() => _ShowWidgetsViewState();
}

class _ShowWidgetsViewState extends State<ShowWidgetsView> {

  Role? role;
  bool toggleField = false;
  int? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 320),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [

              IsselIsselAssetContainer(asset: AppAssets.logo),

              IsselTextFormField(
                hintText: "Nombre de usuario",
                prefixIcon: Icons.person_outline,
                height: 50,
              ),

              IsselButton(
                text: "Ingresar",
                onTap: () => print("Ingresando"),
              ),

              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IsselRadioCard(
                    value: Role.admin,
                    groupValue: role,
                    size: 100,
                    label: "Admin",
                    asset: AppAssets.logo,
                    onChanged: (v) => setState(() => role = v)
                  ),
                  IsselRadioCard(
                    value: Role.calidad,
                    groupValue: role,
                    size: 100,
                    label: "Calidad",
                    asset: AppAssets.logo,
                    onChanged: (v) => setState(() => role = v)
                  ),
                  IsselRadioCard(
                    value: Role.tecnico,
                    groupValue: role,
                    size: 100,
                    label: "Técnico",
                    asset: AppAssets.logo,
                    onChanged: (v) => setState(() => role = v)
                  ),
                ],
              ),

              SizedBox(
                height: 170,
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IsselRadioTile(
                      value: Role.admin,
                      groupValue: role,
                      height: 50,
                      label: "Admin",
                      onChanged: (v) => setState(() => role = v),
                      alignment: Alignment.centerLeft,
                    ),
                    IsselRadioTile(
                      value: Role.calidad,
                      groupValue: role,
                      height: 50,
                      label: "Calidad",
                      onChanged: (v) => setState(() => role = v),
                      alignment: Alignment.centerLeft,
                    ),
                    IsselRadioTile(
                      value: Role.tecnico,
                      groupValue: role,
                      height: 50,
                      label: "Técnico",
                      onChanged: (v) => setState(() => role = v),
                      alignment: Alignment.centerLeft,
                    ),
                  ],
                ),
              ),

              IsselHeaderActionTile(
                title: "Iluminación Q1",
                subTitle: "Salida",
                textButton: "Probar",
                onPressed: () {

                },
              ),

              IsselTabSwitcher(
                leftText: "Crear",
                rightText: "Actualizar",
                onChanged: (value) {
                  print(value);
                },
                state: TabSwitcherAlignStates.left,
              ),

              IsselStepperField(
                title: "Exposición",
                maxValue: 20,
                minValue: -10,
                onChanged: (value) {
                  print(value);
                }
              ),

              IsselInfoField(
                title: "Piezas Ok",
                value: "5"
              ),

              IsselToggleField(
                title: "Luz",
                value: toggleField,
                onChanged: (value) {
                  toggleField = !toggleField;
                  setState(() {});
                },
              ),

              IsselInfoField2(
                icon: Icons.timer_outlined,
                label: "12s"
              ),

              IsselDropdown<int>(
                hintText: "Nombre de usuario",
                items: List.generate(
                  5,
                  (index) {
                    return DropdownMenuItem(
                      child: Text("Valor $index"),
                      value: index,
                    );
                  },
                ),
                value: dropdownValue,
                onChanged: (p0) {
                  dropdownValue = p0;
                  setState(() {});
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}
