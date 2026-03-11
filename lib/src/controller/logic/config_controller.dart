import 'package:arquitectura_cliente_sistema_vision/core/errors/exceptions.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/ctrl_response.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/config_entity.dart';
import 'package:arquitectura_cliente_sistema_vision/src/models/configs_model.dart';
import 'package:flutter/material.dart';

class ConfigController extends ChangeNotifier {

  ConfigsModel configsModel;

  ConfigController({
    required this.configsModel
  });


  List<ConfigEntity> configs = [];

  Future<CtrlResponse<List<ConfigEntity>>> loadDatabases() async {
    try {
      configs = await configsModel.listConfigs();
      return CtrlResponse<List<ConfigEntity>>(success: true, element: configs);
    } on AppException catch(e) {
      return CtrlResponse<List<ConfigEntity>>(success: false, message: e.message);
    }

  }

  Future<CtrlResponse> createDatabase(String name) async {

    try {
      ConfigEntity newConfig = await configsModel.createConfig(name);
      configs.add(newConfig);
      notifyListeners();
      return CtrlResponse(success: true);
    } on AppException catch(e) {
      return CtrlResponse(success: false, message: e.message);
    }

  }

  Future<CtrlResponse> deleteDabatase(ConfigEntity database) async {

    try {
      await configsModel.deleteConfig(database.filename);
      configs.remove(database);
      notifyListeners();
      return CtrlResponse(success: true);
    } on AppException catch(e) {
      return CtrlResponse(success: false, message: e.message);
    }

  }

  //TODO: CAPTURE MASTER IMAGE
  Future<CtrlResponse> captureMasterImage() async {

    try {
      String image = await Future.delayed(const Duration(seconds: 1), () => "https://i.ibb.co/B2Fy6SVC/prueba.jpg",) ;
      return CtrlResponse(success: true, element: image);
    } on AppException catch(e) {
      return CtrlResponse(success: false, message: e.message);
    }

  }

}
