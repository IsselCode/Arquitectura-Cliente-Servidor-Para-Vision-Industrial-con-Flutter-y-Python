import 'dart:typed_data';

import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/camera_controller.dart';
import 'package:bbox_editor/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfigMachineCtrl extends ChangeNotifier {

  CameraController cameraController;
  late BBoxEditorController bBoxEditorController;

  ConfigMachineCtrl({
    required this.cameraController,
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
  
  Uint8List? image;

  Future<void> loadInitialData() async {
    ByteData byteData = await rootBundle.load("assets/prueba.jpg");
    image = byteData.buffer.asUint8List();
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

  //* Tools

}