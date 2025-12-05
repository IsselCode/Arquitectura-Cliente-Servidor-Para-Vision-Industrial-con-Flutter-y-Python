import 'package:arquitectura_cliente_sistema_vision/core/errors/exceptions.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/ctrl_response.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/license_entity.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/device_controller.dart';
import 'package:arquitectura_cliente_sistema_vision/src/models/auth_model.dart';
import 'package:arquitectura_cliente_sistema_vision/src/models/license_model.dart';
import 'package:flutter/material.dart';

class LicenseController extends ChangeNotifier {

  LicenseModel licenseModel;
  DeviceController deviceController;

  LicenseController({
    required this.licenseModel,
    required this.deviceController,
  });

  LicenseEntity? license;

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

  Future<CtrlResponse> activateLicense(String inputLicense) async {
    try {
      // Insertar licencia
      LicenseEntity licenseEntity = await licenseModel.activateLicense(inputLicense);
      license = licenseEntity;
      notifyListeners();
      return CtrlResponse(success: true);
    } on AppException catch(e) {
      return CtrlResponse(success: false, message: e.message);
    }
  }

  Future<CtrlResponse> verifyLicense() async {
    try {
      LicenseEntity licenseEntity = await licenseModel.verifyLicense();
      license = licenseEntity;
      notifyListeners();
      return CtrlResponse(success: true);
    } on AppException catch(e) {
      return CtrlResponse(success: false, message: e.message);
    }
  }


}