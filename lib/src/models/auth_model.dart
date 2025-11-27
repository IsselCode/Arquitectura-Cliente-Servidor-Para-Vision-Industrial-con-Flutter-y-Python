import 'package:arquitectura_cliente_sistema_vision/core/database/user_dao.dart';
import 'package:arquitectura_cliente_sistema_vision/core/errors/exceptions.dart';

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
    throw UnimplementedError();
  }

  Future<UserEntity> insertNormalUser(String name, String pass) async {
    throw UnimplementedError();
  }

  Future<UserEntity> authenticate(String name, String pass) async {
    throw UnimplementedError();
  }

  Future<void> changePassword(int userId, String newPassword) async {
    throw UnimplementedError();
  }

  Future<void> deleteUserById(int uid) async {
    throw UnimplementedError();
  }

  Future<int> countAdmins() async {
    throw UnimplementedError();
  }


}