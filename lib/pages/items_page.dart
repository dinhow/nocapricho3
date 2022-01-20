import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nocapricho3/models/categoria.dart';
import 'package:nocapricho3/pages/add_categoria.dart';
import 'package:nocapricho3/pages/fab_itens_page.dart';
import 'package:nocapricho3/services/database_service.dart';
import 'package:nocapricho3/widgets/category_tile.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                int? id = await DatabaseService().getCategoryIdCount();
                //int newid = id!+1;
                print(id);
              },
              icon: Icon(Icons.production_quantity_limits))
        ],
        centerTitle: true,
        title: Text('Itens'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () => Get.to(() => AddCategoria()),
        child: FaIcon(FontAwesomeIcons.plus),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection("Categorias").snapshots(),
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
                      return CategoriaTile(categoria: documentSnapshot);
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
                      Text('NENHUM ITEM\nADICIONADO\n',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 36)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Comece adicionando\numa categoria',
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
