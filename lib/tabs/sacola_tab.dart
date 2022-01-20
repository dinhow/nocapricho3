import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndialog/ndialog.dart';
import 'package:nocapricho3/models/user_model.dart';
import 'package:nocapricho3/services/database_service.dart';
import 'package:nocapricho3/widgets/modal_bottom.dart';
import 'package:nocapricho3/widgets/product_row.dart';

class SacolaTab extends StatefulWidget {
  const SacolaTab({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  _SacolaTabState createState() => _SacolaTabState();
}

class _SacolaTabState extends State<SacolaTab> {
  @override
  Widget build(BuildContext context) {
    void _showMenu() {
      showModalBottomSheet(
        //backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return ModalBottom();
        },
      );
    }

    final TextEditingController _trocoController = TextEditingController();

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Usuarios")
            .doc(widget.user.id)
            .collection("Sacola")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/empty_bag.png"),
                SizedBox(height: 20),
                Text('SUA SACOLA ESTÁ VAZIA',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700])),
              ],
            ));
          } else if (snapshot.data!.docs.length > 0) {
            int pgto = 0;
            bool money = false;
            Future<double?> subtotal =
                DatabaseService().totalValue(widget.user.id);
            double trocoPara = 0;
            return Column(
              children: [
                Container(color: Colors.grey[200]),
                Expanded(
                  //flex: 5,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.grey[50],
                    child: ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Endereço da Entrega',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            SizedBox(height: 10),
                            Container(
                              color: Colors.grey[200],
                              padding: EdgeInsets.only(bottom: 12),
                              child: ListTile(
                                onTap: () => _showMenu(),
                                isThreeLine: true,
                                leading: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.home,
                                      color: Colors.redAccent,
                                      size: 20,
                                    ),
                                  ],
                                ),
                                title: Text('Casa',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                    'Rua Uirapuru, 274 - Vila Gilcy, Colombo - PR\nCasa 1, Frente'),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(FontAwesomeIcons.ellipsisV,
                                        color: Colors.redAccent, size: 20),
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            Text('Resumo do pedido',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            SizedBox(height: 10),
                            Container(
                              //width: 500,
                              height: 200,
                              child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot documentSnapshot =
                                        snapshot.data!.docs[index];
                                    return ProductRow(
                                        product: documentSnapshot);
                                  }),
                            ),
                            SizedBox(height: 18),
                            Divider(
                              color: Colors.black54,
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Sub-total',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('R\$ ' + subtotal.toString())
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Entrega'),
                                Text(
                                  'à Combinar',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Divider(color: Colors.black54),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total a pagar',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('R\$ 300,00 + taxa de entrega',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Divider(color: Colors.black54),
                            SizedBox(height: 8),
                            Center(
                              child: Text('Forma de pagamento',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ),
                            SizedBox(height: 8),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: CustomRadioButton(
                                    //width: 110,
                                    elevation: 0,
                                    spacing: 0,
                                    enableShape: true,
                                    enableButtonWrap: true,
                                    radioButtonValue: (values) {
                                      //print(values);
                                      setState(() {
                                        pgto = int.parse(values.toString());
                                        print(pgto);
                                      });
                                    },
                                    buttonValues: <int>[0, 1, 2],
                                    buttonLables: ["Cartão", "Dinheiro", "Pix"],
                                    selectedColor: Colors.redAccent,
                                    unSelectedColor:
                                        Theme.of(context).canvasColor),
                              ),
                            ),
                            SizedBox(height: 8),
                            pgto == 1
                                ? Center(
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Text('Precisa de troco?',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18)),
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 50,
                                              child: CustomRadioButton(
                                                  //width: 110,
                                                  elevation: 0,
                                                  spacing: 0,
                                                  enableShape: true,
                                                  enableButtonWrap: true,
                                                  radioButtonValue: (values) {
                                                    print(values);
                                                    setState(() async {
                                                      money = int.parse(values
                                                                  .toString()) ==
                                                              0
                                                          ? false
                                                          : true;
                                                      if (money) {
                                                        NDialog(
                                                          dialogStyle:
                                                              DialogStyle(
                                                                  titleDivider:
                                                                      true),
                                                          title: Text(
                                                              "Troco para quanto?"),
                                                          content: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              TextFormField(
                                                                controller:
                                                                    _trocoController,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                decoration:
                                                                    InputDecoration(
                                                                        hintText:
                                                                            'R\$'),
                                                              ),
                                                            ],
                                                          ),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: Text(
                                                                  "Cancelar"),
                                                              onPressed: () =>
                                                                  Get.back(),
                                                            ),
                                                            TextButton(
                                                              child: Text(
                                                                  "Salvar"),
                                                              onPressed: () {
                                                                trocoPara =
                                                                    double.parse(
                                                                        _trocoController
                                                                            .text);
                                                                Get.back();
                                                              },
                                                            )
                                                          ],
                                                        ).show(
                                                          context,
                                                        );
                                                      }
                                                    });
                                                  },
                                                  buttonValues: <int>[0, 1],
                                                  buttonLables: ["Não", "Sim"],
                                                  selectedColor:
                                                      Colors.redAccent,
                                                  unSelectedColor:
                                                      Theme.of(context)
                                                          .canvasColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            Divider(color: Colors.black54),
                            Center(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      minimumSize: Size(
                                          MediaQuery.of(context).size.width * 9,
                                          50),
                                      textStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      primary: Colors.redAccent),
                                  onPressed: () {
                                    //DatabaseService().newRequest(pedido);
                                  },
                                  child: Text('Finalizar Encomenda')),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/empty_bag.png"),
                SizedBox(height: 20),
                Text('SUA SACOLA ESTÁ VAZIA',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700])),
              ],
            ));
          }
        });

    // isEmpty == true
    //     ? Center(
    //         child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Image.asset("assets/empty_bag.png"),
    //           SizedBox(height: 20),
    //           Text('SUA SACOLA ESTÁ VAZIA',
    //               style: TextStyle(
    //                   fontSize: 25,
    //                   fontWeight: FontWeight.bold,
    //                   color: Colors.grey[700])),
    //         ],
    //       ))
  }
}
