import 'dart:convert';

import 'package:arquitectura_cliente_sistema_vision/core/errors/exceptions.dart';
import 'package:arquitectura_cliente_sistema_vision/core/services/host_port_device_service.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/config_entity.dart';
import 'package:http/http.dart' as http;

class ConfigsModel {

  HostPortDeviceService hostPortDeviceService;

  ConfigsModel({
    required this.hostPortDeviceService,
  });

  Future<List<ConfigEntity>> listConfigs() async {
    try {
      final response = await http.get(hostPortDeviceService.configUri());
      final dynamic decoded = jsonDecode(response.body);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        final message = decoded is Map<String, dynamic> ? (decoded["detail"] ?? decoded["message"] ?? "Error al listar configuraciones").toString() : "Error al listar configuraciones";
        throw AppException(message: message);
      }

      if (decoded is! List) {
        throw AppException(message: "Formato de configuraciones no valido");
      }

      return decoded.map((item) => ConfigEntity.fromJson(item as Map<String, dynamic>)).toList();
    } on AppException catch (e) {
      rethrow;
    } catch (e) {
      print(e);
      throw AppException(message: "Error desconocido");
    }
  }

  Future<ConfigEntity> createConfig(String name) async {
    try {
      final response = await http.post(
        hostPortDeviceService.configUri(),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
        }),
      );
      final dynamic decoded = jsonDecode(response.body);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        final message = decoded is Map<String, dynamic> ? (decoded["detail"] ?? decoded["message"] ?? "Error al crear configuracion").toString() : "Error al crear configuracion";
        throw AppException(message: message);
      }

      if (decoded is! Map<String, dynamic>) {
        throw AppException(message: "Formato de configuracion no valido");
      }

      return ConfigEntity.fromJson(decoded);
    } on AppException catch (e) {
      rethrow;
    } catch (e) {
      throw AppException(message: "Error desconocido");
    }
  }

  Future<void> deleteConfig(String name) async {
    try {
      final response = await http.delete(
        hostPortDeviceService.configUri(name),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 204) {
        return;
      }

      final dynamic decoded = response.body.isNotEmpty ? jsonDecode(response.body) : null;

      if (response.statusCode < 200 || response.statusCode >= 300) {
        final message = decoded is Map<String, dynamic> ? (decoded["detail"] ?? decoded["message"] ?? "Error al eliminar configuración").toString() : "Error al eliminar configuracion";
        throw AppException(message: message);
      }
    } on AppException catch (e) {
      rethrow;
    } catch (e) {
      throw AppException(message: "Error desconocido");
    }
  }

  Future<ConfigEntity> selectCurrentDatabase(String name) async {

    try {

      final response = await http.put(
        hostPortDeviceService.currentUri(name),
        headers: {"Content-Type": "application/json"}
      );

      final dynamic decoded = jsonDecode(response.body);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        final message = decoded is Map<String, dynamic> ? (decoded["detail"] ?? decoded["message"] ?? "Error al seleccionar la configuración").toString() : "Error al seleccionar la configuración";
        throw AppException(message: message);
      }

      return ConfigEntity.fromJson(decoded);

    } on AppException catch(e) {
      rethrow;
    } catch (e) {
      throw AppException(message: "Error desconocido");
    }

  }

}
