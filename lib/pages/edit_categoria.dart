import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nocapricho3/models/categoria.dart';

class EditCategoria extends StatelessWidget {
  const EditCategoria({Key? key, required this.categoria}) : super(key: key);
  final DocumentSnapshot categoria;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nomeController = TextEditingController();
    final TextEditingController _descricaoController = TextEditingController();
    final TextEditingController _valorController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Card(
            child: Container(
              padding: EdgeInsets.all(15),
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Editar Categoria'),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _nomeController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: categoria["nome"]),
                  ),
                  TextFormField(
                    controller: _descricaoController,
                    keyboardType: TextInputType.text,
                    decoration:
                        InputDecoration(hintText: categoria["descricao"]),
                  ),
                  // SizedBox(height: 20),
                  // TextFormField(
                  //   controller: _valorController,
                  //   inputFormatters: [
                  //     MoneyInputFormatter(leadingSymbol: 'R\$')
                  //   ],
                  //   keyboardType: TextInputType.number,
                  //   decoration: InputDecoration(hintText: categoria["valor"]),
                  // ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        if (_nomeController.text != "" &&
                            _valorController.text != "" &&
                            _descricaoController.text != "") {
                          // Database().addData(
                          //     _infoController.text,
                          //     category,
                          //     double.parse(_valueController.text),
                          //     controller.user.uid);
                          // _infoController.clear();
                          // _valueController.clear();
                          // Get.back();
                          // Get.snackbar('Pronto! Produto adicionado com sucesso!',
                          //     snackPosition: SnackPosition.TOP);
                          // FocusScope.of(context).unfocus();
                        } else {
                          // Get.snackbar(
                          //     'ATENÇÃO', 'Nenhum campo pode estar vazio',
                          //     snackPosition: SnackPosition.TOP);
                        }
                      },
                      child: Text('Salvar'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
