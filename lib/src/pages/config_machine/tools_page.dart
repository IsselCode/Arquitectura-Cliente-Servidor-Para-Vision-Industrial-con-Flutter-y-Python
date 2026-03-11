import 'package:bbox_editor/exports.dart';
import 'package:flutter/material.dart';
import 'package:issel_code_widgets/issel_code_widgets.dart';
import 'package:provider/provider.dart';

import '../../../core/app/consts.dart';
import '../../clean_features/dialogs/add_new_tool_dialog.dart';
import '../../controller/ui/config_machine_ctrl.dart';

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorScheme colorScheme = theme.colorScheme;
    ConfigMachineCtrl configMachineCtrl = context.watch();

    return Flex(
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
            IsselDropdown<int>(
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
            IsselStepperField(
              title: "Exposición",
              minValue: 0,
              maxValue: 100,
              onChanged: (value) {

              },
            ),
            IsselToggleField(
              title: "Luz",
              value: false,
              onChanged: (value) {

              },
            )
          ],
        ),
        Divider(color: AppColors.grey,),

        //* Salidas
        Expanded(
          child: Flex(
            direction: Axis.vertical,
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //* Texto y Botón
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Herramientas", style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
                  IconButton(
                      onPressed: () async {

                        String? result = await showDialog<String>(
                          context: context,
                          builder: (context) => AddNewToolDialog(),
                        );

                        if (result != null) {
                          Size size = configMachineCtrl.bBoxEditorController.viewSize;
                          BBoxEntity bbox = BBoxEntity(center: Offset(size.width/2, size.height/2), w: 100, h: 100, tag: result);
                          await configMachineCtrl.bBoxEditorController.addBox(bbox);
                        }
                      },
                      style: IconButton.styleFrom(
                          backgroundColor: colorScheme.surface,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                      ),
                      icon: Icon(Icons.add_outlined)
                  ),
                ],
              ),
              //* Lista de Boundings
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 10,),
                  itemCount: configMachineCtrl.bBoxEditorController.boxes.value.length,
                  itemBuilder: (context, index) {
                    BBoxEntity bbox = configMachineCtrl.bBoxEditorController.boxes.value[index];
                    return ListTile(
                      title: Text(bbox.tag ?? bbox.id.toString()),
                      onTap: () async {
                        await configMachineCtrl.bBoxEditorController.setSelectedBox(bbox.id);
                      },
                      trailing: IconButton(
                          onPressed: () async => await configMachineCtrl.bBoxEditorController.removeBox(bbox.id),
                          icon: Icon(Icons.delete_outline_outlined, color: Colors.red,)
                      ),
                    );
                  },
                ),
              )

            ],
          ),
        ),
      ],
    );
  }
}
