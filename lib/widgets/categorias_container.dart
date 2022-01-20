import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocapricho3/models/categoria.dart';
import 'package:nocapricho3/pages/produtos_page.dart';

class CategoriasContainer extends StatelessWidget {
  final DocumentSnapshot categoria;

  const CategoriasContainer({Key? key, required this.categoria})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ProdutosPage(
            categoria: categoria,
          )),
      child: Container(
        width: 160,
        height: MediaQuery.of(context).size.height,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: NetworkImage(categoria["img"]), fit: BoxFit.cover)),
          child: Column(
            children: [
              Expanded(
                child: Container(),
              ),
              Container(
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    categoria["nome"].toUpperCase(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
