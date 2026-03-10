import 'package:equatable/equatable.dart';
import 'package:sqflite/sqflite.dart';

class ConfigEntity extends Equatable {

  final String filename;
  final String dpName;

  ConfigEntity({
    required this.filename,
    required this.dpName
  });

  factory ConfigEntity.fromJson(Map<String, dynamic> json) {
    return ConfigEntity(
      filename: json["filename"],
      dpName: json["dp_name"],
    );
  }

  ConfigEntity copywith({
    String? filename,
    String? dpName
  }) {
    return ConfigEntity(
      filename: filename ?? this.filename,
      dpName: dpName ?? this.dpName
    );
  }

  @override
  List<Object?> get props => [filename, dpName];

}
