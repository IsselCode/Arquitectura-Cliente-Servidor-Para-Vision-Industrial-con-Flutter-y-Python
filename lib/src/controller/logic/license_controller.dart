import 'package:arquitectura_cliente_sistema_vision/core/errors/exceptions.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/ctrl_response.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/device_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/models/license_model.dart';
import 'package:flutter/material.dart';

class LicenseController extends ChangeNotifier {

  LicenseModel licenseModel;
  DeviceController deviceController;

  LicenseController({
    required this.licenseModel,
    required this.deviceController,
  });

  Future<CtrlResponse> insertLicense(String license) async {
    try {
      bool response = await licenseModel.insertLicense(deviceController.device!, license);
      return CtrlResponse(success: true);
    } on AppException catch(e) {
      return CtrlResponse(
        success: false,
        message: e.message,
      );
    }
  }

}