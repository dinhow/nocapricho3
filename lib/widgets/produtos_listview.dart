import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nocapricho3/widgets/product_tile.dart';
import 'package:nocapricho3/widgets/produtos_container.dart';

class ProdutosListview extends StatelessWidget {
  const ProdutosListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Produtos")
                //.where('categoria', isEqualTo: categoria["nome"])
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
            }));

    // GetX<ProdutoController>(
    //   init: Get.put<ProdutoController>(ProdutoController()),
    //   builder: (ProdutoController produtoController) {
    //     if (produtoController != null && produtoController.infoData != null) {
    //       return produtoController.infoData.length != 0
    //           ? Container(
    //               height: MediaQuery.of(context).size.height,
    //               child: ListView.builder(
    //                   itemCount: produtoController.infoData.length,
    //                   itemBuilder: (_, index) {
    //                     return ProdutosContainer(
    //                       produto: produtoController.infoData[index],
    //                     );
    //                   }),
    //             )
    //           : Center(child: Text('Nenhum produto cadastrado'));
    //     } else {
    //       return Center(child: CircularProgressIndicator());
    //     }
    //   },
    // );
  }
}
