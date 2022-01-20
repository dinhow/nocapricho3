import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriaModel {
  late final int id;
  late final String img;
  late final String nome;
  late final String? descricao;
  late final bool ativo;
  late final DateTime dateCreated;

  CategoriaModel(
      {required this.id,
      required this.img,
      required this.nome,
      required this.ativo,
      required this.dateCreated,
      this.descricao = ''});

  CategoriaModel.fromDocumentSnapshot({DocumentSnapshot? documentSnapshot}) {
    id = documentSnapshot!["id"];
    img = documentSnapshot["img"];
    nome = documentSnapshot["nome"];
    descricao = documentSnapshot["descricao"];
    ativo = documentSnapshot["ativo"];
    dateCreated = documentSnapshot["dateCreated"];
  }
}
