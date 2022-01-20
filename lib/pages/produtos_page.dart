import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nocapricho3/models/categoria.dart';
import 'package:nocapricho3/pages/add_categoria.dart';
import 'package:nocapricho3/pages/add_produto.dart';
import 'package:nocapricho3/pages/fab_itens_page.dart';
import 'package:nocapricho3/widgets/category_tile.dart';
import 'package:nocapricho3/widgets/product_tile.dart';

class ProdutosPage extends StatelessWidget {
  const ProdutosPage({Key? key, required this.categoria}) : super(key: key);
  final DocumentSnapshot categoria;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(categoria["nome"]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () => Get.to(() => AddProduto(categoria: categoria["nome"])),
        child: FaIcon(FontAwesomeIcons.plus),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Produtos")
              .where('categoria', isEqualTo: categoria["nome"])
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.redAccent,
              ));
            } else if (snapshot.data!.docs.length > 0) {
              return Container(
                color: Colors.white,
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                      return ProdutoTile(produto: documentSnapshot);
                    }),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('NENHUM PRODUTO\nADICIONADO',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 36)),
                    ],
                  ),
                ],
              );
            }
          }),
    ));
  }
}
