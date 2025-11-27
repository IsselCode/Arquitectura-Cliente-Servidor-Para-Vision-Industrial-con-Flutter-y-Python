import 'package:arquitectura_cliente_sistema_vision/core/errors/exceptions.dart';

enum AppRole {

  admin(label: "Admin"),
  user(label: "Usuario");

  final String label;
  const AppRole({required this.label});

  static fromString(String role) {
    switch (role) {
      case "admin":
        return AppRole.admin;
      case "user":
        return AppRole.user;
      default:
        throw AppException(message: "Rol no identificado");
    }
  }

}