import 'dart:convert';
import 'package:arquitectura_cliente_sistema_vision/core/errors/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/device_entity.dart';

class LicenseModel {

  Future<bool> insertLicense(DeviceEntity device, String license) async {

    final url = Uri.parse('http://${device.host}:${device.port}/api/config/license');

    final body = jsonEncode({
      "license": license,
    });

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      final decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decoded["license"] == true;
      } else {
        throw AppException(message: decoded["detail"]);
      }

    } on AppException catch(e) {
      rethrow;
    }
    catch (e) {
      throw AppException(message: "Error no implementado");
    }

  }

}