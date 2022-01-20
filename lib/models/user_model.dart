import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nocapricho3/models/endereco.dart';
import 'package:nocapricho3/models/pedido.dart';

class UserModel {
  late String? id;
  late String? name;
  late String? email;
  late List? endereco;
  late List? pedidos;
  late bool? ativo;
  late bool? admin;
  late Timestamp? dateCreated;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.pedidos,
      this.endereco,
      this.ativo,
      this.admin,
      this.dateCreated});

  UserModel.fromDocumentSnapshot({DocumentSnapshot? documentSnapshot}) {
    id = documentSnapshot!.id;
    name = documentSnapshot["name"] ?? '';
    email = documentSnapshot["email"] ?? '';
    pedidos = documentSnapshot["pedidos"] ?? [];
    endereco = documentSnapshot["endereco"] ?? [];
    ativo = documentSnapshot["ativo"] ?? true;
    admin = documentSnapshot["admin"] ?? false;
    dateCreated = documentSnapshot["dateCreated"] ?? Timestamp.now();
  }
}
