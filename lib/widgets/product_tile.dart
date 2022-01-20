import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ndialog/ndialog.dart';
import 'package:nocapricho3/models/produto.dart';
import 'package:nocapricho3/pages/edit_item_page.dart';
import 'package:nocapricho3/pages/produto.dart';
import 'package:nocapricho3/pages/produtos_page.dart';
import 'package:nocapricho3/services/database_service.dart';

class ProdutoTile extends StatelessWidget {
  const ProdutoTile({Key? key, required this.produto}) : super(key: key);
  final DocumentSnapshot produto;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: ListTile(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProdutoPage(
                        produto: produto,
                      ))),
          onLongPress: () async {
            NDialog(
              dialogStyle: DialogStyle(titleDivider: true),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FaIcon(FontAwesomeIcons.exclamationTriangle,
                      color: Colors.amber),
                  Text("Atenção"),
                  FaIcon(FontAwesomeIcons.exclamationTriangle,
                      color: Colors.amber),
                ],
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Deseja excluir este produto?'),
                          Text('Esta ação não poderá ser desfeita!'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancelar"),
                  onPressed: () => Get.back(),
                ),
                TextButton(
                  child: Text("S I M",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    DatabaseService().removeProduct(produto);
                    Get.snackbar('', 'Produto removido com sucesso');
                    Get.back();
                  },
                )
              ],
            ).show(
              context,
            );
          },
          isThreeLine: true,
          leading: CircleAvatar(
            backgroundImage: NetworkImage(produto["img"]),
          ),
          title: Text(
            produto["nome"],
            style:
                TextStyle(color: Colors.grey[850], fontWeight: FontWeight.w500),
          ),
          subtitle: Text(produto["descricao"]),
        ),
      ),
    );
  }
}
