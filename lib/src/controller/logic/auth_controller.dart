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

}