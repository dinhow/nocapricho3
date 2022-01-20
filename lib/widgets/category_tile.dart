import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ndialog/ndialog.dart';
import 'package:nocapricho3/models/categoria.dart';
import 'package:nocapricho3/models/produto.dart';
import 'package:nocapricho3/pages/add_categoria.dart';
import 'package:nocapricho3/pages/add_produto.dart';
import 'package:nocapricho3/pages/edit_categoria.dart';
import 'package:nocapricho3/pages/produtos_page.dart';
import 'package:nocapricho3/services/database_service.dart';

class CategoriaTile extends StatelessWidget {
  const CategoriaTile({Key? key, required this.categoria}) : super(key: key);
  final DocumentSnapshot categoria;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: ListTile(
          onTap: () => Get.to(() => ProdutosPage(
                categoria: categoria,
              )),
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
                          Text('Deseja excluir esta categoria?'),
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
                    DatabaseService().removeCategory(categoria);
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
            backgroundImage: NetworkImage(categoria["img"]),
          ),
          title: Text(
            categoria["nome"],
            style:
                TextStyle(color: Colors.grey[850], fontWeight: FontWeight.w500),
          ),
          subtitle: Text(categoria["descricao"]),
        ),
      ),
    );
  }
}
