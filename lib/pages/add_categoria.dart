import 'dart:io';
import 'dart:ui';
import 'package:camera_camera/camera_camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:nocapricho3/models/categoria.dart';
import 'package:nocapricho3/pages/items_page.dart';
import 'package:nocapricho3/pages/preview_page.dart';
import 'package:nocapricho3/services/database_service.dart';
import 'package:image/image.dart' as img;

class AddCategoria extends StatefulWidget {
  AddCategoria({Key? key});

  @override
  _AddCategoriaState createState() => _AddCategoriaState();
}

class _AddCategoriaState extends State<AddCategoria> {
  File? imageFile;
  final picker = ImagePicker();

  final FirebaseStorage storage = FirebaseStorage.instance;

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
          .uploadImage(file.path, categoryName, 'category');

      task.snapshotEvents.listen((TaskSnapshot snapshot) async {
        if (snapshot.state == TaskState.running) {
          setState(() {
            uploading = true;
            total = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          });
        } else if (snapshot.state == TaskState.success) {
          int? id = await DatabaseService().getCategoryIdCount();
          String imgUrl = await storage
              .ref('images/category/img-$categoryName')
              .getDownloadURL();

          DatabaseService().addCategory(CategoriaModel(
              id: id! + 1,
              img: imgUrl,
              nome: categoryName,
              descricao: categoryDescription,
              ativo: true,
              dateCreated: DateTime.now()));

          Get.to(ItemsPage());
        }
      });
    }
  }

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  String categoryName = "Clique para adicionar um nome";
  String categoryDescription = "Clique para adicionar uma descrição";
  bool uploading = false;
  double total = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          title: uploading
              ? Text('${total.round()}% enviado')
              : Text("Nova Categoria", style: TextStyle(color: Colors.white)),
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
                                    categoryName =
                                        "Clique para adicionar um nome";
                                    categoryDescription =
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
                                      categoryName = _nomeController.text;
                                      categoryDescription =
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
                              Text(categoryName,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              SizedBox(height: 8),
                              Text(categoryDescription,
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
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
