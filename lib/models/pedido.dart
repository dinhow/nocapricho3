import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nocapricho3/models/produto.dart';

class PedidoModel {
  late String? id;
  late String? userId;
  List<ProdutoModel>? produtos;
  late double? valorEntrega;
  late double? totalPedido;
  late String? observacao;
  late bool? retirada;
  late int? status;
  late int? pgto;
  late DateTime? dateCreated;

  PedidoModel(
      {this.id,
      this.userId,
      this.produtos,
      this.valorEntrega,
      this.totalPedido,
      this.observacao,
      this.retirada,
      this.status,
      this.pgto,
      this.dateCreated});

  PedidoModel.fromDocumentSnapshot({DocumentSnapshot? documentSnapshot}) {
    id = documentSnapshot!.id;
    userId = documentSnapshot["userId"] ?? '';
    produtos = documentSnapshot["produtos"] ?? [];
    valorEntrega = documentSnapshot["valorEntrega"] ?? 0;
    totalPedido = documentSnapshot["TotalPedido"] ?? 0;
    observacao = documentSnapshot["observacao"] ?? '';
    retirada = documentSnapshot["retirada"] ?? false;
    status = documentSnapshot["status"] ?? 0;
    pgto = documentSnapshot["pgto"] ?? 0;
    dateCreated = documentSnapshot["dateCreated"] ?? DateTime.now();
  }
}
