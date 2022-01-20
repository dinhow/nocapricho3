import 'package:cloud_firestore/cloud_firestore.dart';

class EnderecoModel {
  late String? id;
  late String? rua;
  late String? bairro;
  late String? cidade;
  late String? cep;
  late String? numero;
  late String? observacao;

  EnderecoModel(
      {this.id,
      this.rua,
      this.bairro,
      this.cidade,
      this.cep,
      this.numero,
      this.observacao});

  EnderecoModel.fromDocumentSnapshot({DocumentSnapshot? documentSnapshot}) {
    id = documentSnapshot!.id;
    rua = documentSnapshot["rua"];
    bairro = documentSnapshot["bairro"];
    cidade = documentSnapshot["cidade"];
    cep = documentSnapshot["cep"];
    numero = documentSnapshot["numero"];
    observacao = documentSnapshot["observacao"];
  }
}
