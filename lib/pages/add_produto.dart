import 'dart:io';
import 'dart:ui';
import 'package:camera_camera/camera_camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:nocapricho3/models/produto.dart';
import 'package:nocapricho3/pages/items_page.dart';
import 'package:nocapricho3/pages/preview_page.dart';
import 'package:nocapricho3/services/database_service.dart';

class AddProduto extends StatefulWidget {
  AddProduto({Key? key, required this.categoria});
  String categoria;

  @override
  _AddProdutoState createState() => _AddProdutoState(categoria);
}

class _AddProdutoState extends State<AddProduto> {
  File? imageFile;
  final picker = ImagePicker();
  final String categoria;

  final FirebaseStorage storage = FirebaseStorage.instance;

  _AddProdutoState(this.categoria);

  Future showPreview(file) async {
    file = await Get.to(() => PreviewPage(file: file));
    if (file != null) {
      setState(() => imageFile = file);
      Get.back();
    }
  }

  Future getFileFromGallery() async {
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() => imageFile = File(file.path));
      print(imageFile);
    }
  }

  submit() async {
    File? file = imageFile;
    if (file != null) {
      UploadTask task = await DatabaseService()
          .uploadImage(file.path, productName, 'product');

      task.snapshotEvents.listen((TaskSnapshot snapshot) async {
        if (snapshot.state == TaskState.running) {
          setState(() {
            uploading = true;
            total = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          });
        } else if (snapshot.state == TaskState.success) {
          int? id = await DatabaseService().getProductIdCount();

          String imgUrl = await storage
              .ref('images/product/img-$productName')
              .getDownloadURL();

          DatabaseService().addProduct(ProdutoModel(
              id: id! + 1,
              img: imgUrl,
              nome: productName,
              categoria: categoria,
              descricao: productDescription,
              vezesComprado: 1,
              tamanho: {"P": 9.9, "M": 11.9, "G": 12.9},
              ativo: true,
              dateCreated: DateTime.now()));

          Get.back();
        }
      });
    }
  }

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  String productName = "Clique para adicionar um nome";
  String productDescription = "Clique para adicionar uma descrição";
  bool uploading = false;
  double total = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          // leading: IconButton(
          //     onPressed: () => {},
          //     //Get.back(),
          //     icon: FaIcon(FontAwesomeIcons.arrowLeft)),
          title: uploading
              ? Text('${total.round()}% enviado')
              : Text("Novo Produto", style: TextStyle(color: Colors.white)),
          actions: [
            uploading
                ? Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Center(
                      child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 3, color: Colors.white)),
                    ),
                  )
                : IconButton(
                    onPressed: () async {
                      NDialog(
                        dialogStyle: DialogStyle(titleDivider: true),
                        title: Text("Salvar"),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('As informações estão corretas?'),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text("Cancelar"),
                            onPressed: () => Get.back(),
                          ),
                          TextButton(
                            child: Text("Sim"),
                            onPressed: () {
                              submit();
                              Get.back();
                            },
                          )
                        ],
                      ).show(
                        context,
                      );
                    },
                    icon: FaIcon(FontAwesomeIcons.save))
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[200],
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(15)),
                  margin: EdgeInsets.all(15),
                  child: Column(children: [
                    Expanded(
                        flex: 4,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                imageFile == null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ElevatedButton.icon(
                                              onPressed: () => Get.to(() =>
                                                  CameraCamera(
                                                      onFile: (file) =>
                                                          showPreview(file))),
                                              icon: FaIcon(
                                                  FontAwesomeIcons.camera),
                                              label: Padding(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Text('Tirar uma foto'),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  textStyle:
                                                      TextStyle(fontSize: 18))),
                                          Padding(
                                              padding: EdgeInsets.all(12),
                                              child: Text('ou')),
                                          OutlinedButton.icon(
                                              onPressed: () =>
                                                  getFileFromGallery(),
                                              icon: FaIcon(FontAwesomeIcons
                                                  .solidFileImage),
                                              label:
                                                  Text('Selecionar da galeria'))
                                        ],
                                      )
                                    : Stack(
                                        children: [
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .9,
                                              // child: Image.file(
                                              //   imageFile!,
                                              //   fit: BoxFit.cover,
                                              // ),
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image:
                                                        FileImage(imageFile!)),
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15)),
                                              )),
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor: Colors.black
                                                      .withOpacity(.5),
                                                  child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          imageFile = null;
                                                        });
                                                      },
                                                      icon: FaIcon(
                                                        FontAwesomeIcons.times,
                                                        size: 20,
                                                      )),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                              ],
                            ),
                          ),
                        )
                        //imageFile != null ? Image.file(imageFile!) : NetworkImage('url')
                        ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () async {
                          NDialog(
                            dialogStyle: DialogStyle(titleDivider: false),
                            //title: Text("Coloque o nome e descrição"),
                            content: Container(
                              padding: EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width * .8,
                              height: MediaQuery.of(context).size.height * .2,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _nomeController,
                                    keyboardType: TextInputType.text,
                                    decoration:
                                        InputDecoration(hintText: 'Nome'),
                                  ),
                                  TextFormField(
                                    controller: _descricaoController,
                                    keyboardType: TextInputType.text,
                                    decoration:
                                        InputDecoration(hintText: 'Descrição'),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text("Cancelar"),
                                onPressed: () {
                                  setState(() {
                                    productName =
                                        "Clique para adicionar um nome";
                                    productDescription =
                                        "Clique para adicionar uma descrição";
                                    _descricaoController.clear();
                                    _nomeController.clear();
                                    Get.back();
                                  });
                                },
                              ),
                              TextButton(
                                child: Text("Salvar"),
                                onPressed: () {
                                  if (_nomeController.text == '' &&
                                      _descricaoController.text == '') {
                                    print("Erro");
                                  } else {
                                    setState(() {
                                      productName = _nomeController.text;
                                      productDescription =
                                          _descricaoController.text;
                                      _descricaoController.clear();
                                      _nomeController.clear();
                                      Get.back();
                                    });
                                  }
                                },
                              )
                            ],
                          ).show(
                            context,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(productName,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              SizedBox(height: 8),
                              Text(productDescription,
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(15),
                  color: Colors.grey[50],
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tamanhos',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 19)),
                            Text('Valores',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 19)),
                          ],
                        ),
                        // SizedBox(height: 8),
                        // Container(
                        //   width: MediaQuery.of(context).size.width,
                        //   height: 50,
                        //   child: ListView(
                        //     children: [],
                        //   ),
                        // ),
                        // SizedBox(height: 8),

                        // //SizedBox(height: 8),
                        // Divider(),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     // Text(
                        //     //   'TOTAL: ',
                        //     //   style: TextStyle(
                        //     //       fontWeight: FontWeight.bold, fontSize: 18),
                        //     // ),
                        //     // Text('R\$' + produto!.valor.toStringAsPrecision(4),
                        //     //     style: TextStyle(fontSize: 18))
                        //   ],
                        // ),
                        // SizedBox(height: 8),
                        // Center(
                        //   child: ElevatedButton(
                        //       style: ElevatedButton.styleFrom(
                        //           shape: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(30)),
                        //           minimumSize: Size(
                        //               MediaQuery.of(context).size.width * 9,
                        //               50),
                        //           textStyle: TextStyle(
                        //               fontSize: 15,
                        //               fontWeight: FontWeight.bold),
                        //           primary: Colors.redAccent),
                        //       onPressed: () async {
                        //         NDialog(
                        //           dialogStyle: DialogStyle(titleDivider: true),
                        //           title: Text("Salvar"),
                        //           content: Row(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               Text('As informações estão corretas?'),
                        //             ],
                        //           ),
                        //           actions: <Widget>[
                        //             TextButton(
                        //               child: Text("Cancelar"),
                        //               onPressed: () => Get.back(),
                        //             ),
                        //             TextButton(
                        //               child: Text("Sim"),
                        //               onPressed: () {},
                        //             )
                        //           ],
                        //         ).show(
                        //           context,
                        //         );
                        //       },
                        //       child: Text('Adicionar')),
                        // )
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:nocapricho3/models/categoria.dart';
// import 'package:nocapricho3/models/produto.dart';
// import 'package:nocapricho3/services/database_service.dart';

// class AddProduto extends StatelessWidget {
//   const AddProduto({Key? key, this.categoria}) : super(key: key);
//   final DocumentSnapshot? categoria;

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController _nomeController = TextEditingController();
//     final TextEditingController _descricaoController = TextEditingController();
//     final TextEditingController _valorController = TextEditingController();
//     final formKey = GlobalKey<FormState>();
//     final picker = ImagePicker();
//     File? imageFile;

//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Adicionar Produto'),
//         ),
//         body: Center(
//           child: Card(
//             child: Container(
//               padding: EdgeInsets.all(15),
//               height: 600,
//               child: Form(
//                 key: formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(height: 20),
//                     GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         decoration: BoxDecoration(
//                             image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image:
//                                     AssetImage('assets/images/picture.png'))),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     TextFormField(
//                       controller: _nomeController,
//                       keyboardType: TextInputType.text,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(), labelText: "Nome"),
//                     ),
//                     SizedBox(height: 20),
//                     TextFormField(
//                       controller: _descricaoController,
//                       keyboardType: TextInputType.text,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(), labelText: 'Descrição'),
//                     ),
//                     SizedBox(height: 20),
//                     TextFormField(
//                       controller: _valorController,
//                       inputFormatters: [
//                         MoneyInputFormatter(leadingSymbol: 'R\$')
//                       ],
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(), labelText: 'Valor'),
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                         onPressed: () {
//                           if (_nomeController.text != "" &&
//                               _valorController.text != "" &&
//                               _descricaoController.text != "") {
//                             DatabaseService().addProduto(ProdutoModel(
//                                 id: 5,
//                                 img: 'img',
//                                 nome: _nomeController.text,
//                                 categoria: 'Teste',
//                                 descricao: _descricaoController.text,
//                                 valor: double.parse(_valorController.text),
//                                 vezesComprado: 0,
//                                 tamanho: 5,
//                                 ativo: true,
//                                 dateCreated: DateTime.now()));
//                             _valorController.clear();
//                             _nomeController.clear();
//                             _descricaoController.clear();
//                             FocusScope.of(context).unfocus();
//                             Navigator.pop(context);
//                           } else {
//                             // Get.snackbar(
//                             //     'ATENÇÃO', 'Nenhum campo pode estar vazio',
//                             //     snackPosition: SnackPosition.TOP);
//                           }
//                         },
//                         child: Text('Adicionar'))
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// // class AddProduto extends StatefulWidget {
// //   const AddProduto({Key? key, this.categoria}) : super(key: key);
// //   final DocumentSnapshot? categoria;
  
// //   @override
// //   _AddProdutoState createState() => _AddProdutoState();
// // }

// // class _AddProdutoState extends State<AddProduto> {
// //   final TextEditingController _nomeController = TextEditingController();
// //   final TextEditingController _descricaoController = TextEditingController();
// //   final TextEditingController _valorController = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //         body: Center(
// //           child: Card(
// //             child: Container(
// //               padding: EdgeInsets.all(15),
// //               height: 400,
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Text(categoria!.id != null
// //                       ? 'Adicionar Produto'
// //                       : 'Adicionar Produto'),
// //                   SizedBox(
// //                     height: 20,
// //                   ),
// //                   TextFormField(
// //                     controller: _nomeController,
// //                     keyboardType: TextInputType.text,
// //                     decoration: InputDecoration(hintText: 'Nome do Produto'),
// //                   ),
// //                   TextFormField(
// //                     controller: _descricaoController,
// //                     keyboardType: TextInputType.text,
// //                     decoration: InputDecoration(hintText: 'Descrição'),
// //                   ),
// //                   SizedBox(height: 20),
// //                   TextFormField(
// //                     controller: _valorController,
// //                     inputFormatters: [
// //                       MoneyInputFormatter(leadingSymbol: 'R\$')
// //                     ],
// //                     keyboardType: TextInputType.number,
// //                     decoration: InputDecoration(hintText: 'Valor'),
// //                   ),
// //                   SizedBox(height: 20),
// //                   ElevatedButton(
// //                       onPressed: () {
// //                         if (_nomeController.text != "" &&
// //                             _valorController.text != "" &&
// //                             _descricaoController.text != "") {
// //                           // Database().addData(
// //                           //     _infoController.text,
// //                           //     category,
// //                           //     double.parse(_valueController.text),
// //                           //     controller.user.uid);
// //                           // _infoController.clear();
// //                           // _valueController.clear();
// //                           // Get.back();
// //                           // Get.snackbar('Pronto! Produto adicionado com sucesso!',
// //                           //     snackPosition: SnackPosition.TOP);
// //                           // FocusScope.of(context).unfocus();
// //                         } else {
// //                           // Get.snackbar(
// //                           //     'ATENÇÃO', 'Nenhum campo pode estar vazio',
// //                           //     snackPosition: SnackPosition.TOP);
// //                         }
// //                       },
// //                       child: Text('Adicionar'))
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
