import 'package:arquitectura_cliente_sistema_vision/core/app/enums.dart';

class UserEntity {

  final int id;
  final String name;
  final String encryptPass;
  final AppRole role;
  final DateTime createAt;

  UserEntity({
    required this.id,
    required this.name,
    required this.encryptPass,
    required this.role,
    required this.createAt
  });

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map["id"],
      name: map["name"],
      encryptPass: map["pass"],
      role: AppRole.fromString(map["role"]),
      createAt: DateTime.parse(map["create_at"])
    );
  }

}