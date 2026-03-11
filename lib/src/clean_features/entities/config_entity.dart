import 'package:equatable/equatable.dart';

class ConfigEntity extends Equatable {

  final int? id;
  final String dpName;
  final String filename;
  final int? piezasOk;
  final int? piezasNg;
  final String? configPlc;
  final String? imgMaestra;
  final DateTime? createdAt;

  ConfigEntity({
    required this.dpName,
    required this.filename,
    this.id,
    this.piezasOk,
    this.piezasNg,
    this.configPlc,
    this.imgMaestra,
    this.createdAt,
  });

  factory ConfigEntity.fromJson(Map<String, dynamic> json) {
    return ConfigEntity(
      id: json["id"],
      dpName: json["dp_name"],
      filename: json["filename"],
      piezasOk: json["piezas_ok"],
      piezasNg: json["piezas_ng"],
      configPlc: json["config_plc"],
      imgMaestra: json["img_maestra"],
      createdAt: json["created_at"] != null
          ? DateTime.parse(json["created_at"].toString().replaceFirst(" ", "T"))
          : null,
    );
  }

  ConfigEntity copywith({
    int? id,
    String? dpName,
    String? filename,
    int? piezasOk,
    int? piezasNg,
    String? configPlc,
    String? imgMaestra,
    DateTime? createdAt,
  }) {
    return ConfigEntity(
      id: id ?? this.id,
      dpName: dpName ?? this.dpName,
      filename: filename ?? this.filename,
      piezasOk: piezasOk ?? this.piezasOk,
      piezasNg: piezasNg ?? this.piezasNg,
      configPlc: configPlc ?? this.configPlc,
      imgMaestra: imgMaestra ?? this.imgMaestra,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    dpName,
    filename,
    piezasOk,
    piezasNg,
    configPlc,
    imgMaestra,
    createdAt,
  ];

}
