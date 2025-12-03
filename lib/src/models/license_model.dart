import 'dart:convert';
import 'package:arquitectura_cliente_sistema_vision/core/errors/exceptions.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/license_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/device_entity.dart';

const _LicenseKey = "licenseKey";
const _LicenseLimit = "licenseLimit";
const _ResponsablePersonName = "responsablePersonName";
const _Client = "client";
const _System = "system";

class LicenseModel {

  FirebaseFirestore firestore;
  FlutterSecureStorage storage;

  LicenseModel({
    required this.firestore,
    required this.storage
  });

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
      throw UnimplementedError("Error desconocido");
    }

  }

  Future<LicenseEntity> activateLicense(String license) async {

    try {
      // Verificar si existe la licencia
      CollectionReference colRef = firestore.collection("licenses");
      DocumentReference docRef = colRef.doc(license);
      DocumentSnapshot docSnap = await docRef.get();
      bool exists = docSnap.exists;
      if (!exists) {
        throw AppException(message: "La licencia no existe");
      }

      final data = docSnap.data() as Map<String, dynamic>;
      final int uses = data["uses"];
      final int limit = data["limit"];

      // Actualizar el estado a true en Firestore
      if (uses + 1 >= limit) {
        await docRef.update({"status": true, "uses": FieldValue.increment(1)});
      } else {
        await docRef.update({"uses": FieldValue.increment(1)});
      }

      // Leer datos del documento
      final String responsablePersonName = data["responsable_person_name"];
      final String company = data["company"];
      final String system = data["system"];

      // Guardar la licencia en secure storage
      await storage.write(key: _LicenseKey, value: true.toString());
      await storage.write(key: _LicenseLimit, value: limit.toString());
      await storage.write(key: _Client, value: company);
      await storage.write(key: _System, value: system);
      await storage.write(key: _ResponsablePersonName, value: responsablePersonName);

      return LicenseEntity(
        activated: true,
        limit: limit,
        company: company,
        system: system,
        responsablePersonName: responsablePersonName
      );

    } on AppException catch(e) {
      rethrow;
    } on FirebaseException catch (e) {
      String error = "Error del servidor";
      if (e.code == "permission-denied"){
        error = "La licencia ya fue activada";
      }
      throw AppException(message: error);
    } catch (e) {
      throw AppException(message: "Error desconocido");
    }
  }

  Future<LicenseEntity> verifyLicense() async {
    try {

      final activatedStr = await storage.read(key: _LicenseKey);
      final limitStr = await storage.read(key: _LicenseLimit);
      final company = await storage.read(key: _Client);
      final system = await storage.read(key: _System);
      final responsablePersonName = await storage.read(key: _ResponsablePersonName);

      // Validar que TODOS los datos existan
      final hasAllData = [
        activatedStr,
        limitStr,
        company,
        system,
        responsablePersonName
      ].every((value) => value != null && value.trim().isNotEmpty);

      if (!hasAllData) {
        throw AppException(message: "Licencia no activada.");
      }

      // Convertir valores
      final activated = activatedStr == "true";
      final limit = int.tryParse(limitStr!) ?? 0;

      return LicenseEntity(
        activated: activated,
        limit: limit,
        company: company!,
        system: system!,
        responsablePersonName: responsablePersonName!
      );

    } on AppException catch (e) {
      rethrow;
    } catch (e) {
      throw AppException(message: "Error desconocido");
    }
  }

}