import 'package:arquitectura_cliente_sistema_vision/core/errors/exceptions.dart';

enum AppRole {

  admin(label: "Admin"),
  quality(label: "Calidad"),
  technician(label: "Técnico");

  final String label;
  const AppRole({required this.label});

  static fromString(String role) {
    switch (role) {
      case "admin":
        return AppRole.admin;
      case "quality":
        return AppRole.quality;
      case "technician":
        return AppRole.technician;
      default:
        throw AppException(message: "Rol no identificado");
    }
  }

}