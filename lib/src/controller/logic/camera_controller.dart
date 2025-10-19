import 'package:flutter/material.dart';
import '../../models/camera_model.dart';

class CameraController extends ChangeNotifier {

  CameraModel cameraModel;

  CameraController({
    required this.cameraModel
  });

  Future<Size> startCamera() => cameraModel.startCamera();

  String streamCamera() => cameraModel.streamCamera();

}