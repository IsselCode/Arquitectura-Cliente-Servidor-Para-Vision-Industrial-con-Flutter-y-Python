import 'package:arquitectura_cliente_sistema_vision/core/app/enums.dart';
import 'package:arquitectura_cliente_sistema_vision/core/errors/exceptions.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/ctrl_response.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/user_entity.dart';
import 'package:arquitectura_cliente_sistema_vision/src/models/auth_model.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {

  AuthModel authModel;

  AuthController({
    required this.authModel
  });

  UserEntity? user;

  Future<CtrlResponse> authenticate(String name, String pass) async {

    try {
      UserEntity response = await authModel.authenticate(name, pass);
      user = response;
      return CtrlResponse(success: true);
    } on AppException catch(e) {
      return CtrlResponse(success: false, message: e.message);
    }

  }

  Future<CtrlResponse> insertNormalUser(String name, String pass, AppRole role) async {
    try {
      String stringRole = role.name;
      name = name.trim();
      UserEntity response = await authModel.insertNormalUser(name, pass, stringRole);
      user = response;
      return CtrlResponse(success: true, message: "Usuario creado correctamente");
    } on AppException catch(e) {
      return CtrlResponse(success: false, message: e.message);
    }
  }

  Future<CtrlResponse> insertAdminUser(String name, String pass) async {

    try {
      name = name.trim();
      UserEntity response = await authModel.insertAdminUser(name, pass);
      user = response;
      return CtrlResponse(success: true);
    } on AppException catch(e) {
      return CtrlResponse(success: false, message: e.message);
    }

  }

  Future<int> countAdmins() => authModel.countAdmins();

  Future<CtrlResponse> getUsers() async {
    try {
      List<UserEntity> response = await authModel.getUsers();
      return CtrlResponse(success: true, element: response);
    } on AppException catch(e) {
      return CtrlResponse(success: false, message: e.message);
    }
  }

}