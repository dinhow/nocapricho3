import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:badges/badges.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nocapricho3/models/produto.dart';
import 'package:nocapricho3/models/user_model.dart';
import 'package:nocapricho3/services/auth_service.dart';
import 'package:nocapricho3/services/database_service.dart';

class ProdutoPage extends StatefulWidget {
  ProdutoPage({Key? key, required this.produto, this.user});
  final DocumentSnapshot produto;
  final UserModel? user;

  @override
  _ProdutoPageState createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  final formatCurrency =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'R\$');
  double total = 0;
  double unityPrice = 0;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    DocumentSnapshot? produto = widget.produto;
    String userId = AuthService().currentUser();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            Badge(
              position: BadgePosition.bottomStart(start: 1, bottom: 1),
              badgeColor: Colors.lightBlueAccent,
              badgeContent: Text('15',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              child: IconButton(
                onPressed: () {},
                icon: FaIcon(FontAwesomeIcons.shoppingBasket),
              ),
            )
          ],
          title: Text(
            widget.produto["nome"],
          ),
        ),
        body: ListView(
          children: [
            Container(
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
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          widget.produto["img"])))),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(widget.produto["nome"],
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                SizedBox(height: 8),
                                Text(widget.produto["descricao"],
                                    style: TextStyle(
                                        color: Colors.grey[700], fontSize: 15)),
                              ],
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
                            Text('Selecione o tamanho',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 19)),
                            SizedBox(height: 8),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  CustomRadioButton(
                                      //width: 110,
                                      //defaultSelected: 9.9,
                                      elevation: 0,
                                      spacing: 0,
                                      enableShape: true,
                                      enableButtonWrap: true,
                                      radioButtonValue: (values) {
                                        setState(() {
                                          unityPrice =
                                              double.parse(values.toString());
                                          total = quantity * unityPrice;
                                          print(unityPrice);
                                          print(unityPrice * quantity);
                                        });
                                      },
                                      buttonValues: [9.9, 10.9, 11.9],
                                      buttonLables: [
                                        "Pequena",
                                        "Média",
                                        "Grande"
                                      ],
                                      selectedColor: Colors.redAccent,
                                      unSelectedColor:
                                          Theme.of(context).canvasColor),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text('Selecione a quantidade',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 19)),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (quantity != 1 && quantity != 0)
                                          quantity--;
                                        total = quantity * unityPrice;
                                      });
                                      total = quantity * unityPrice;
                                      print(quantity);
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.minus,
                                      color: Colors.redAccent,
                                    )),
                                Text(
                                  quantity.toString(),
                                  style: TextStyle(
                                    fontSize: 25,
                                    //fontWeight: FontWeight.bold
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        quantity++;
                                        total = quantity * unityPrice;
                                      });
                                      print(quantity);
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.plus,
                                      color: Colors.redAccent,
                                    )),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${formatCurrency.format(total)}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
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
                                    if (total != 0) {
                                      DatabaseService().addToBag(produto,
                                          unityPrice, quantity, userId);
                                      Get.back();
                                    } else {
                                      Get.snackbar(
                                          'Atenção', 'Selecione um tamanho',
                                          snackPosition: SnackPosition.BOTTOM);
                                    }
                                  },
                                  child: Text('Adicionar a sacola')),
                            ),
                            SizedBox(height: 12)
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
