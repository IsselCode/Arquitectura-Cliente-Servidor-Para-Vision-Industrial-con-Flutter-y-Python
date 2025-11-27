import 'package:sqflite/sqflite.dart';

class UserDAO {
  final Database db;
  UserDAO({required this.db});

  // Obtener todos los usuarios
  Future<List<Map<String, Object?>>> getUsers() => db.query(
    "users",
    orderBy: "name ASC",
  );

  // Buscar usuario por id
  Future<Map<String, Object?>?> findUserById(int id) async {
    final result = await db.query(
      "users",
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Buscar usuario por nombre (exacto)
  Future<Map<String, Object?>?> findUserByName(String name) async {
    final result = await db.query(
      "users",
      where: "name = ?",
      whereArgs: [name],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Buscar usuarios por nombre (LIKE, case-insensitive)
  Future<List<Map<String, Object?>>> findUsersByNamePattern(String name) {
    return db.query(
      "users",
      where: "name LIKE ? COLLATE NOCASE",
      whereArgs: ["%$name%"],
      orderBy: "name ASC",
    );
  }

  // === CREAR USUARIO SOLO COMO ADMIN ===
  //
  // Esta función SIEMPRE crea el usuario con rol "admin".
  // (La lógica de "solo un administrador puede llamar a esto"
  // la manejas tú en la capa de UI/servicio, revisando el usuario logueado.)
  Future<int> insertAdminUser({
    required String name,
    required String password,
  }) {
    return db.insert("users", {
      "name": name,
      "pass": password, // idealmente ya encriptado/hasheado
      "role": "admin",
    });
  }

  // Crear usuario normal (role = 'user')
  Future<int> insertNormalUser({
    required String name,
    required String password,
  }) {
    return db.insert("users", {
      "name": name,
      "pass": password,
      "role": "user",
    });
  }

  // Cambiar contraseña
  Future<int> changePassword({
    required int userId,
    required String newPassword,
  }) {
    return db.update(
      "users",
      {
        "pass": newPassword,
      },
      where: "id = ?",
      whereArgs: [userId],
    );
  }

  // Eliminar usuario por id
  // Si intentas eliminar al último admin, el trigger lanzará una excepción.
  Future<int> deleteUserById(int id) {
    return db.delete(
      "users",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // Contar admins, por si quieres verificar desde Dart.
  Future<int> countAdmins() async {
    final result = await db.rawQuery(
      "SELECT COUNT(*) AS total FROM users WHERE role = 'admin';",
    );
    final row = result.first;
    final total = row["total"] as int? ?? 0;
    return total;
  }
}
