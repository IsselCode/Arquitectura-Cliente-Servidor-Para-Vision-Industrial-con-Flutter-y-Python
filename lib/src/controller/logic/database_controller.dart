import 'package:arquitectura_cliente_sistema_vision/core/errors/exceptions.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/ctrl_response.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/database_entity.dart';
import 'package:flutter/material.dart';

class DatabaseController extends ChangeNotifier {

  List<DatabaseEntity> databases = [];

  Future<CtrlResponse> loadDatabases() async {

    try {
      databases = await Future.delayed(const Duration(seconds: 1), () => fakeDatabases,);
      return CtrlResponse(success: true, element: databases);
    } on AppException catch(e) {
      return CtrlResponse(success: false, message: e.message);
    }

  }

  Future<CtrlResponse> createDatabase(String name) async {

    try {
      DatabaseEntity databaseEntity = await Future.delayed(const Duration(seconds: 1), () => throw AppException(message: "Método no implementado"),);
      return CtrlResponse(success: true);
    } on AppException catch(e) {
      return CtrlResponse(success: false, message: e.message);
    }

  }

  Future<CtrlResponse> deleteDabatase(DatabaseEntity database) async {

    try {
      await Future.delayed(const Duration(seconds: 1), () => throw AppException(message: "Método no implementado"),);
      return CtrlResponse(success: true);
    } on AppException catch(e) {
      return CtrlResponse(success: false, message: e.message);
    }

  }

  Future<CtrlResponse> captureMasterImage() async {

    try {
      String image = await Future.delayed(const Duration(seconds: 1), () => "https://i.ibb.co/B2Fy6SVC/prueba.jpg",) ;
      return CtrlResponse(success: true, element: image);
    } on AppException catch(e) {
      return CtrlResponse(success: false, message: e.message);
    }

  }

}