import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nocapricho3/widgets/categorias_container.dart';

class CategoriasListview extends StatefulWidget {
  const CategoriasListview({Key? key}) : super(key: key);

  @override
  _CategoriasListviewState createState() => _CategoriasListviewState();
}

class _CategoriasListviewState extends State<CategoriasListview> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Categorias").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.redAccent,
            ));
          } else if (snapshot.data!.docs.length > 0) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  return Row(
                    children: [
                      CategoriasContainer(categoria: documentSnapshot),
                      SizedBox(width: 8)
                    ],
                  );
                });
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('NENHUMA CATEGORIA \nADICIONADA',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                  ],
                ),
              ],
            );
          }
        });
    //   Center(child: Text('Cat_ListView')),
    // );

    // GetX<CategoriaController>(
    //   init: Get.put<CategoriaController>(CategoriaController()),
    //   builder: (CategoriaController categoriaController) {
    //     if (categoriaController != null &&
    //         categoriaController.infoData != null) {
    //       return categoriaController.infoData.length != 0
    //           ? ListView.builder(
    //               scrollDirection: Axis.horizontal,
    //               itemCount: categoriaController.infoData.length,
    //               itemBuilder: (_, index) {
    //                 return Row(
    //                   children: [
    //                     CategoriasContainer(
    //                       categoria: categoriaController.infoData[index],
    //                     ),
    //                     SizedBox(
    //                       width: 5,
    //                     )
    //                   ],
    //                 );
    //               },
    //             )
    //           : GestureDetector(
    //               child: Container(
    //                 width: MediaQuery.of(context).size.width,
    //                 height: MediaQuery.of(context).size.height,
    //                 decoration: BoxDecoration(
    //                     image: DecorationImage(
    //                         colorFilter: ColorFilter.mode(
    //                             Colors.red.withOpacity(.2), BlendMode.dstATop),
    //                         fit: BoxFit.cover,
    //                         image: NetworkImage(
    //                             "http://www.pe.senac.br/wp-content/uploads/2021/04/WhatsApp-Image-2021-04-12-at-17.34.13.jpeg"))),
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Text(
    //                       'NENHUMA CATEGORIA',
    //                       style: TextStyle(
    //                           fontSize: 30, fontWeight: FontWeight.bold),
    //                     ),
    //                     Text(
    //                       'ADICIONADA',
    //                       style: TextStyle(
    //                           fontSize: 30, fontWeight: FontWeight.bold),
    //                     ),
    //                     Text('Clique aqui para começar a adicionar categorias!')
    //                   ],
    //                 ),
    //               ),
    //             );
    //     } else {
    //       return Center(child: CircularProgressIndicator());
    //     }
    //   },
    // );

//     ListView(
//       scrollDirection: Axis.horizontal,
//       children: [
//         Container(
//           width: 160,
//           height: MediaQuery.of(context).size.height,
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               image: DecorationImage(
//                   image: NetworkImage(
//                       "https://www.sabornamesa.com.br/media/k2/items/cache/bbfb4faa18ee2951b02b656fb34be1d7_L.jpg"),
//                   fit: BoxFit.cover),
//             ),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: Container(),
//                 ),
//                 Container(
//                   height: 35,
//                   decoration: BoxDecoration(
//                       color: Colors.green[200],
    // borderRadius: BorderRadius.only(
    //     bottomLeft: Radius.circular(15),
    //     bottomRight: Radius.circular(15))),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'FITNESS',
//                         style: TextStyle(
// //                      backgroundColor: Colors.green[200],
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 5,
//         ),
//         Container(
//           width: 160,
//           height: MediaQuery.of(context).size.height,
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               image: DecorationImage(
//                   image: NetworkImage(
//                       "https://static1.casapraticaqualita.com.br/articles/6/88/6/@/944-marmitas-com-atum-podem-estragar-no-calo-article_content_img-2.jpg"),
//                   fit: BoxFit.cover),
//             ),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: Container(),
//                 ),
//                 Container(
//                   height: 35,
//                   decoration: BoxDecoration(
//                       color: Colors.blue[200],
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(15),
//                           bottomRight: Radius.circular(15))),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'NORMAIS',
//                         style: TextStyle(
//                             color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 5,
//         ),
//         Container(
//           color: Colors.grey[200],
//           width: 160,
//           height: MediaQuery.of(context).size.height,
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               image: DecorationImage(
//                   image: NetworkImage(
//                       "https://conteudo.imguol.com.br/c/entretenimento/29/2020/05/26/sopa-de-feijao-com-macarrao-1590515359013_v2_450x337.jpg"),
//                   fit: BoxFit.cover),
//             ),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: Container(),
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                       color: Colors.pinkAccent[100],
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(15),
//                           bottomRight: Radius.circular(15))),
//                   height: 35,
//                   //color: Colors.pinkAccent[100],
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'SOPAS',
//                         style: TextStyle(
//                             color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 5,
//         ),
//         Container(
//           width: 160,
//           height: MediaQuery.of(context).size.height,
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               image: DecorationImage(
//                   image: NetworkImage(
//                       "https://www.receiteria.com.br/wp-content/uploads/receitas-de-suco.jpg"),
//                   fit: BoxFit.cover),
//             ),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: Container(),
//                 ),
//                 Container(
//                   height: 35,
//                   decoration: BoxDecoration(
//                       color: Colors.amberAccent[100],
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(15),
//                           bottomRight: Radius.circular(15))),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'BEBIDAS',
//                         style: TextStyle(
// //                      backgroundColor: Colors.green[200],
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
  }
}
