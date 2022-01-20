import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nocapricho3/models/categoria.dart';
import 'package:nocapricho3/models/pedido.dart';
import 'package:nocapricho3/models/produto.dart';
import 'package:nocapricho3/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class DatabaseException implements Exception {
  String message;
  DatabaseException(this.message);
}

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<bool> createNewUser(UserModel user) async {
    try {
      _db.collection("Usuarios").doc(user.id).set({
        "id": user.id,
        "name": user.name,
        "email": user.email,
        "ativo": true,
        "admin": false,
        "pedidos": [],
        "endereco": [],
        "dateCreated": DateTime.now()
      });
      return true;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot _doc = await _db.collection("Usuarios").doc(uid).get();
      return UserModel.fromDocumentSnapshot(documentSnapshot: _doc);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future<int?> getProductIdCount() async {
    try {
      DocumentSnapshot _doc =
          await _db.collection("productCount").doc("idCounter").get();
      if (_doc.data() != null) {
        Map<String, dynamic> data = _doc.data()! as Map<String, dynamic>;
        int? lastCount = data['count'];
        return lastCount;
      }
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future<int?> getCategoryIdCount() async {
    try {
      DocumentSnapshot _doc =
          await _db.collection("categoryCount").doc("idCounter").get();
      if (_doc.data() != null) {
        Map<String, dynamic> data = _doc.data()! as Map<String, dynamic>;
        int? lastCount = data['count'];
        return lastCount;
      }
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future<firebase_storage.UploadTask> uploadImage(
      String filePath, String name, String type) async {
    File? file = File(filePath);
    try {
      String ref = 'images/$type/img-$name';

      return storage.ref(ref).putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  Future addCategory(CategoriaModel categoria) async {
    try {
      _db.collection("Categorias").doc(categoria.nome).set({
        'id': categoria.id,
        'nome': categoria.nome,
        'img': categoria.img,
        'descricao': categoria.descricao,
        'ativo': true,
        'dateCreated': categoria.dateCreated
      });
      _db
          .collection("categoryCount")
          .doc("idCounter")
          .set({'count': categoria.id});
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future updateCategory(CategoriaModel categoria) async {
    try {
      _db.collection("Categoria").doc(categoria.nome).update({
        'nome': categoria.nome,
        'img': categoria.img,
        'descricao': categoria.descricao,
        'ativo': categoria.ativo,
      });
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future removeCategory(DocumentSnapshot categoria) async {
    await _db
        .collection("Categorias")
        .doc(categoria["nome"])
        .delete()
        .then((value) => print('Categoria ${categoria["nome"]} excluída.'))
        .catchError((error) => print('Erro ao excluir categoria'));
    await storage.ref('images/category/img-${categoria["nome"]}').delete();
  }

  Future addProduct(ProdutoModel produto) async {
    try {
      _db.collection("Produtos").doc(produto.nome).set({
        'nome': produto.nome,
        'img': produto.img,
        'descricao': produto.descricao,
        'categoria': produto.categoria,
        //'valor': produto.valor,
        'ativo': produto.ativo,
        'tamanho': produto.tamanho,
        'vezesComprado': produto.vezesComprado,
        'dateCreated': produto.dateCreated
      });
      _db
          .collection("productCount")
          .doc("idCounter")
          .set({'count': produto.id});
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future updateProduct(ProdutoModel produto) async {
    try {
      _db.collection("Produtos").doc(produto.nome).update({
        'nome': produto.nome,
        'img': produto.img,
        'descricao': produto.descricao,
        'categoria': produto.categoria,
        //'valor': produto.valor,
        'ativo': produto.ativo,
        'tamanho': produto.tamanho,
      });
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future removeProduct(DocumentSnapshot produto) async {
    await _db
        .collection("Produtos")
        .doc(produto["nome"])
        .delete()
        .then((value) => print('Produto ${produto["nome"]} excluído.'))
        .catchError((error) => print('Erro ao excluir produto'));
    await storage.ref('images/product/img-${produto["nome"]}').delete();
  }

  // Future initBag(PedidoModel pedido, DocumentSnapshot produto, String userId) async {
  //   //se sacola.lenght == 0 || sacola.lenght == null
  //   if (pedido.status == 0) {
  //     newBag(pedido, produto, userId);
  //   } else {
  //     updateBag(pedido, produto, userId);
  //   }
  // }

  Future addToBag(DocumentSnapshot produto, double valor, int quantidade,
      String userId) async {
    try {
      String itemId = DateTime.now().millisecondsSinceEpoch.toString();
      await _db
          .collection("Usuarios")
          .doc(userId)
          .collection("Sacola")
          .doc(itemId)
          .set({
        'id': itemId,
        'nome': produto["nome"],
        'valor': valor,
        'quantidade': quantidade,
      });
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future changeItemBag(int quantity, String userId, DocumentSnapshot produto,
      String itemId) async {
    try {
      await _db
          .collection("Usuarios")
          .doc(userId)
          .collection("Sacola")
          .doc(itemId)
          .update(
              {'valor': produto["valor"], 'quantidade': produto["quantidade"]});
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future removeItemBag(String itemId, String userId) async {
    try {
      await _db
          .collection("Usuarios")
          .doc(userId)
          .collection("Sacola")
          .doc(itemId)
          .delete();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future cleanBag(String pedidoId, String userId) async {
    try {
      _db
          .collection("Usuarios")
          .doc(userId)
          .collection("Sacola")
          .doc(pedidoId)
          .delete();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future newRequest(PedidoModel pedido) async {
    try {
      DocumentSnapshot _doc = await _db
          .collection("Usuarios")
          .doc(pedido.userId)
          .collection("Sacola")
          .doc(pedido.id)
          .get();
      PedidoModel request =
          PedidoModel.fromDocumentSnapshot(documentSnapshot: _doc);
      await _db.collection("Pedidos").doc().set({
        'id': request.id,
        'userId': request.userId,
        'produtos': request.produtos,
        'valorEntrega': request.valorEntrega,
        'totalPedido': request.totalPedido,
        'obs': request.observacao,
        'retirada': request.retirada,
        'pgto': pedido.pgto,
        'dateCreated': DateTime.now(),
        'status': 1
      });
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  //   Future<int?> getCategoryIdCount() async {
  //   try {
  //     DocumentSnapshot _doc =
  //         await _db.collection("categoryCount").doc("idCounter").get();
  //     if (_doc.data() != null) {
  //       Map<String, dynamic> data = _doc.data()! as Map<String, dynamic>;
  //       int? lastCount = data['count'];
  //       return lastCount;
  //     }
  //   } catch (e) {
  //     throw DatabaseException(e.toString());
  //   }
  // }

  Future<double?> totalValue(String? userId) async {
    double total = 0;
    _db
        .collection("Users")
        .doc(userId)
        .collection("Bag")
        .snapshots()
        .listen((snapshot) {
      for (DocumentSnapshot item in snapshot.docs) {
        Map<String, dynamic> data = item.data()! as Map<String, dynamic>;
        total += data["valor"];
      }
    });
    return total;
  }
}
