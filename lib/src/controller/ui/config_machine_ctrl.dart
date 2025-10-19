import 'dart:typed_data';

import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/camera_controller.dart';
import 'package:bbox_editor/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfigMachineCtrl extends ChangeNotifier {

  CameraController cameraController;
  late BBoxEditorController bBoxEditorController;
  late final VoidCallback _boxesListener;

  ConfigMachineCtrl({
    required this.cameraController,
  }) {
    bBoxEditorController = BBoxEditorController();
    bBoxEditorController.events.listen((event) {
      switch (event) {
        case BoxCreated():
          notifyListeners();
        case BoxUpdated():

        case BoxDeleted():

        case BoxSelected():

        case BoxesCleared():
      }
    },);
  }
  
  Uint8List? image;

  Future<void> loadInitialData() async {
    ByteData byteData = await rootBundle.load("assets/prueba.jpg");
    image = byteData.buffer.asUint8List();
  }

  //* Boundings

}