import 'dart:convert';
import 'package:nsd/nsd.dart';

import '../clean_features/entities/device_entity.dart';

class DeviceModel {

  Future<List<DeviceEntity>> discoverWithNsd() async {

    try {

      final discovery = await startDiscovery('_http._tcp');
      final out = <DeviceEntity>[];

      discovery.addServiceListener((service, status) async {
        final resolved = await resolve(service);
        final host = resolved.host;   // puede ser hostname; nsd resuelve IP internamente
        final port = resolved.port ?? 80;
        final Map<String, dynamic> txt = {
          for (final entry in (resolved.txt ?? {}).entries)
            entry.key: (entry.value is List<int>)
                ? utf8.decode(entry.value as List<int>)
                : entry.value.toString(),
        };

        final bool license = txt["license"] == "true";

        out.add(DeviceEntity(resolved.name ?? '', host ?? '', port, txt, license));
      });

      // Espera ~3–5 s a que aparezcan
      await Future.delayed(const Duration(seconds: 5));
      await stopDiscovery(discovery);
      return out;
    } catch (e) {
      throw UnimplementedError();
    }

  }

}