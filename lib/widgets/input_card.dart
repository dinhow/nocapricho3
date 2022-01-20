import 'package:nocapricho3/widgets/info_tile.dart';
import 'package:flutter/material.dart';

class InputCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('InputCard')),
    );

    // Column(
    //   children: [
    //     GetX<CategoriaController>(
    //       init: Get.put<CategoriaController>(CategoriaController()),
    //       builder: (CategoriaController categoriaController) {
    //         if (categoriaController != null &&
    //             categoriaController.infoData != null) {
    //           return Expanded(
    //             child: ListView.builder(
    //               itemCount: categoriaController.infoData.length,
    //               itemBuilder: (_, index) {
    //                 return Card(
    //                   child: InfoTile(
    //                       //uid: controller.user.uid,
    //                       color: Colors.blue,
    //                       observacao: 'obs',
    //                       info: categoriaController.infoData[index]),
    //                 );
    //               },
    //             ),
    //           );
    //         } else {
    //           return Center(child: CircularProgressIndicator());
    //         }
    //       },
    //     ),
    //     GetX<ProdutoController>(
    //       init: Get.put<ProdutoController>(ProdutoController()),
    //       builder: (ProdutoController categoriaController) {
    //         if (categoriaController != null &&
    //             categoriaController.infoData != null) {
    //           return Expanded(
    //             child: ListView.builder(
    //               itemCount: categoriaController.infoData.length,
    //               itemBuilder: (_, index) {
    //                 return Card(
    //                   child: InfoTile(
    //                       //uid: controller.user.uid,
    //                       color: Colors.blue,
    //                       observacao: 'obs',
    //                       info: categoriaController.infoData[index]),
    //                 );
    //               },
    //             ),
    //           );
    //         } else {
    //           return Center(child: CircularProgressIndicator());
    //         }
    //       },
    //     ),
    //   ],
    // );
  }
}
