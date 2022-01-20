import 'package:cloud_firestore/cloud_firestore.dart';

class ProdutoModel {
  int id;
  String img;
  String nome;
  String categoria;
  String descricao;
  //double valor;
  int vezesComprado;
  Map<String, double> tamanho;
  List<int>? avaliacao;
  bool ativo;
  DateTime dateCreated;

  ProdutoModel(
      {required this.id,
      required this.img,
      required this.nome,
      required this.categoria,
      required this.descricao,
      //required this.valor,
      required this.vezesComprado,
      required this.tamanho,
      this.avaliacao,
      required this.ativo,
      required this.dateCreated});
}
