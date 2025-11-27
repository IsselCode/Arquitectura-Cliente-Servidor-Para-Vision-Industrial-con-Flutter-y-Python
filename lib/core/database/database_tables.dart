import 'package:sqflite/sqflite.dart';

class DatabaseTables {

  Future<void> initTables(Database db) async {

    await db.transaction((txn) async {

    },);

  }

  Future<void> users(Transaction txn) async {

    // Tabla de usuarios
    await txn.execute("""
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        pass TEXT NOT NULL,
        role TEXT NOT NULL CHECK (role IN ("admin", "user")) DEFAULT "user",  
        create_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now'))
      )
    """);

    // Impedir eliminar al último administrador
    await txn.execute("""
      CREATE TRIGGER IF NOT EXISTS prevent_delete_last_admin
      BEFORE DELETE ON users
      WHEN OLD.role = 'admin'
        AND (SELECT COUNT(*) FROM users WHERE role = 'admin') <= 1
      BEGIN
        SELECT RAISE(ABORT, 'No se puede eliminar el último administrador');
      END;
    """);

    // Impedir cambiar de admin -> otro rol si es el último admin
    await txn.execute("""
      CREATE TRIGGER IF NOT EXISTS prevent_downgrade_last_admin
      BEFORE UPDATE OF role ON users
      WHEN OLD.role = 'admin'
        AND NEW.role <> 'admin'
        AND (SELECT COUNT(*) FROM users WHERE role = 'admin') <= 1
      BEGIN
        SELECT RAISE(ABORT, 'No se puede quitar el rol de admin al último administrador');
      END;
    """);
  }

}