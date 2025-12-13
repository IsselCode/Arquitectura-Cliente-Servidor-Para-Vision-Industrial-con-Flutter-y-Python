import 'package:equatable/equatable.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseEntity extends Equatable {

  final int id;
  final String name;
  final String? image;

  DatabaseEntity({
    required this.id,
    required this.name,
    this.image,
  });

  DatabaseEntity copywith({
    String? name,
    String? image
  }) {
    return DatabaseEntity(
      id: id,
      name: name ?? this.name,
      image: image ?? this.image
    );
  }

  @override
  List<Object?> get props => [id, name, image];

}

List<DatabaseEntity> fakeDatabases = [
  DatabaseEntity(id: 1, name: "Sistema 1", image: "https://i.ibb.co/B2Fy6SVC/prueba.jpg"),
  DatabaseEntity(id: 2, name: "Sistema 2"),
  DatabaseEntity(id: 3, name: "Sistema 3", image: "https://i.ibb.co/B2Fy6SVC/prueba.jpg"),
];