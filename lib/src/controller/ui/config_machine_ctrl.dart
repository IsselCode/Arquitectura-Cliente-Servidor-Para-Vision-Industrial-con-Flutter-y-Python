import 'dart:typed_data';

import 'package:arquitectura_cliente_sistema_vision/core/services/toast_service.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/dialogs/confirm_dialog.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/ctrl_response.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/database_entity.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/camera_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/database_controller.dart';
import 'package:bbox_editor/exports.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ConfigMachineCtrl extends ChangeNotifier {

  BuildContext context;

  // Services
  ToastService toastService;

  // Logic Controllers
  DatabaseController databaseController;
  late BBoxEditorController bBoxEditorController;

  // Properties
  DatabaseEntity database;

  ConfigMachineCtrl({
    required this.context,
    required this.toastService,
    required this.databaseController,
    required this.database
  }) {
    bBoxEditorController = BBoxEditorController();
    bBoxEditorController.events.listen((event) async {
      switch (event) {
        case BoxCreated():
          notifyListeners();
          await Future.delayed(const Duration(seconds: 5));
        case BoxUpdated():
          notifyListeners();
        case BoxDeleted():
          notifyListeners();
        case BoxSelected():

        case BoxesCleared():
      }
    },);
  }

  //! BboxEditor
  void captureMasterImage(bool reCapture) async {
    
    bool? reCaptureResult;
    if (reCapture){
      
      reCaptureResult = await showDialog(
        context: context,
        builder: (context) => ConfirmDialog(
          title: "Re-Capturar",
          message: "¿Estas seguro que quieres volver a capturar la imagen?"
        ),
      );

      if (reCaptureResult == null || !reCaptureResult) return;
      
    }

    context.loaderOverlay.show();
    CtrlResponse response = await databaseController.captureMasterImage();
    context.loaderOverlay.hide();

    if (response.success) {
      toastService.success("Imagen capturada");
      database = database.copywith(image: response.element!);
      notifyListeners();
    } else {
      toastService.error(response.message!);
    }

  }

  //! Machine
  TextEditingController plcIp = TextEditingController();
  int okPiece = 0;
  int notOkPiece = 0;

  void connectToPlc() async {}

  void testIllumination() async {}

  void testOkSignal() async {}

  void testNotOkSignal() async {}

  void resetCounters() async {}

  //! Tools

}