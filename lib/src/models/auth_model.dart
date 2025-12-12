import 'package:arquitectura_cliente_sistema_vision/core/app/enums.dart';
import 'package:arquitectura_cliente_sistema_vision/core/database/user_dao.dart';
import 'package:arquitectura_cliente_sistema_vision/core/errors/exceptions.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:sqflite/sqflite.dart';

import '../clean_features/entities/user_entity.dart';

class AuthModel {

  UserDAO userDAO;

  AuthModel({
    required this.userDAO,
  });

  Future<List<UserEntity>> getUsers() async {

    try {
      List<Map<String, dynamic>> usersMap = await userDAO.getUsers();
      return usersMap.map((e) => UserEntity.fromMap(e),).toList();
    } on AppException catch(e) {
      rethrow;
    } catch (e) {
      throw AppException(message: "Error desconocido");
    }

  }

  Future<UserEntity> findUserById(int id) async {

    try {
      Map<String, dynamic>? userMap = await userDAO.findUserById(id);

      if (userMap == null){
        throw AppException(message: "Usuario no encontrado");
      }

      return UserEntity.fromMap(userMap);
    } on AppException catch(e) {
      rethrow;
    } catch (e) {
      throw AppException(message: "Error desconocido");
    }

  }

  Future<UserEntity> findUserByName(String name) async {

    try {
      Map<String, dynamic>? userMap = await userDAO.findUserByName(name);

      if (userMap == null) {
        throw AppException(message: "Usuario no encontrado");
      }
      return UserEntity.fromMap(userMap);
    } on AppException catch(e) {
      rethrow;
    } catch (e) {
      throw AppException(message: "Error desconocido");
    }

  }

  Future<List<UserEntity>> findUsersByNamePattern(String name) async {

    try {
      List<Map<String, dynamic>> usersMap = await userDAO.findUsersByNamePattern(name);
      return usersMap.map((e) => UserEntity.fromMap(e),).toList();
    } on AppException catch(e) {
      rethrow;
    } catch (e) {
      throw AppException(message: "Error desconocido");
    }

  }

  Future<UserEntity> insertAdminUser(String name, String pass) async {

    try {
      String hashedPassword = BCrypt.hashpw(pass, BCrypt.gensalt());
      int id = await userDAO.insertAdminUser(name: name, password: hashedPassword);

      return UserEntity(
        id: id,
        name: name,
        encryptPass: hashedPassword,
        role: AppRole.admin,
        createAt: DateTime.now()
      );

    } on AppException catch(e) {
      rethrow;
    } catch (e) {
      throw AppException(message: "Error desconocido");
    }

  }

  Future<UserEntity> insertNormalUser(String name, String pass, String role) async {
    try {
      String hashedPassword = BCrypt.hashpw(pass, BCrypt.gensalt());
      int id = await userDAO.insertNormalUser(name: name, password: hashedPassword, role: role);

      return UserEntity(
        id: id,
        name: name,
        encryptPass: hashedPassword,
        role: AppRole.fromString(role),
        createAt: DateTime.now()
      );

    }
    on DatabaseException catch(e) {
      String message = "Error al crear";
      if (e.getResultCode() == 2067) {
        message = "El usuario ya existe";
      }
      throw AppException(message: message);
    } on AppException catch(e) {
      rethrow;
    } catch (e) {
      throw AppException(message: "Error desconocido");
    }
  }

  Future<UserEntity> updateUser(int userId, String name, AppRole role) async {

    try {

      int affectedRows = await userDAO.updateUser(userId: userId, name: name, role: role.name);

      return await findUserById(userId);

    } on DatabaseException catch(e) {
      String message = "Error al actualizar";
      if (e.getResultCode() == 1811) {
        message = "No puedes actualizar el único admin";
      }
      throw AppException(message: message);
    } on AppException catch(e) {
      rethrow;
    } catch (e) {
      throw AppException(message: "Error desconocido");
    }

  }

  Future<UserEntity> authenticate(String name, String pass) async {
    try {

      UserEntity userEntity = await findUserByName(name);

      final isValid = BCrypt.checkpw(pass, userEntity.encryptPass);

      if (!isValid) throw AppException(message: "Credenciales incorrectas");

      return userEntity;

    } on AppException catch(e) {
      rethrow;
    } catch (e) {
      throw AppException(message: "Error desconocido");
    }
  }

  Future<void> changePassword(int userId, String oldPassword, String newPassword) async {

    try {

      UserEntity userEntity = await findUserById(userId);

      final isValid = BCrypt.checkpw(oldPassword, userEntity.encryptPass);

      if (!isValid) throw AppException(message: "Credenciales incorrectas");

      await userDAO.changePassword(userId: userId, newPassword: newPassword);

    } on AppException catch(e) {
      rethrow;
    } catch (e) {
      throw AppException(message: "Error desconocido");
    }

  }

  Future<void> deleteUserById(int uid) async {
    try {
      await userDAO.deleteUserById(uid);
    } on DatabaseException catch(e) {
      String message = "Error al eliminar";
      if (e.getResultCode() == 1811) {
        message = "No puedes eliminar el unico administrador";
      }
      throw AppException(message: message);
    }
    on AppException catch (e) {
      rethrow;
    } catch (e) {
      throw AppException(message: "Error desconocido");
    }

  }

  Future<int> countAdmins() async {
    try {
      return await userDAO.countAdmins();
    } on AppException catch (e) {
      rethrow;
    } catch (e) {
      throw AppException(message: "Error desconocido");
    }
  }


}