import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nocapricho3/models/user_model.dart';
import 'package:nocapricho3/services/auth_service.dart';
import 'package:nocapricho3/services/database_service.dart';
import 'package:nocapricho3/tabs/admin_tab.dart';
import 'package:nocapricho3/tabs/pedidos_tab.dart';
import 'package:nocapricho3/tabs/perfil_tab.dart';
import 'package:nocapricho3/tabs/principal_tab.dart';
import 'package:nocapricho3/tabs/sacola_tab.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TabItem<dynamic>> adminTabs = [
    TabItem(
        icon: Center(child: FaIcon(FontAwesomeIcons.home)), title: 'Principal'),
    TabItem(
        icon: Center(child: FaIcon(FontAwesomeIcons.shoppingBasket)),
        title: 'Sacola'),
    TabItem(
        icon: Center(child: FaIcon(FontAwesomeIcons.list)), title: 'Pedidos'),
    TabItem(
        icon: Center(child: FaIcon(FontAwesomeIcons.userAlt)), title: 'Perfil'),
    TabItem(
        icon: Center(child: FaIcon(FontAwesomeIcons.userCog)), title: 'Admin'),
  ];

  final List<TabItem<dynamic>> userTabs = [
    TabItem(
        icon: Center(child: FaIcon(FontAwesomeIcons.home)), title: 'Principal'),
    TabItem(
        icon: Center(child: FaIcon(FontAwesomeIcons.shoppingBasket)),
        title: 'Sacola'),
    TabItem(
        icon: Center(child: FaIcon(FontAwesomeIcons.list)), title: 'Pedidos'),
    TabItem(
        icon: Center(child: FaIcon(FontAwesomeIcons.userAlt)), title: 'Perfil'),
  ];

  TabController? _controller;
  int selectedPage = 0;
  String userId = AuthService().currentUser();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
        future: DatabaseService().getUser(userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SafeArea(child: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Center(
              child: Text("$snapshot.error"),
            );
          } else {
            UserModel user = snapshot.data!;
            bool? ativo = user.ativo;
            bool? admin = user.admin;
            return SafeArea(
                child: (ativo == true)
                    ? Scaffold(
                        appBar: AppBar(
                          elevation: 1,
                          centerTitle: true,
                          backgroundColor: Colors.grey[50],
                          leading: IconButton(
                              onPressed: AuthService().logout,
                              icon: FaIcon(
                                FontAwesomeIcons.bars,
                                color: Theme.of(context).primaryColor,
                              )),
                          title: GestureDetector(
                            onTap: () => {},
                            //_showMenu(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  user.endereco != []
                                      ? user.endereco.toString()
                                      : 'Clique para adicionar um endereço',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 15),
                                ),
                                Icon(
                                  Icons.arrow_downward,
                                  color: Theme.of(context).primaryColor,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                          actions: [
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("Usuarios")
                                    .doc(userId)
                                    .collection("Sacola")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return IconButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedPage = 1;
                                        });
                                      },
                                      icon: FaIcon(
                                          FontAwesomeIcons.shoppingBasket),
                                      color: Theme.of(context).primaryColor,
                                    );
                                  } else if (snapshot.data!.docs.length > 0) {
                                    int itemsQtt = snapshot.data!.docs.length;
                                    return Badge(
                                      position: BadgePosition.bottomStart(
                                          start: 1, bottom: 1),
                                      badgeColor: Colors.lightBlueAccent,
                                      badgeContent: Text(itemsQtt.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedPage = 1;
                                          });
                                        },
                                        icon: FaIcon(
                                            FontAwesomeIcons.shoppingBasket),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    );
                                  } else {
                                    return IconButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedPage = 1;
                                        });
                                      },
                                      icon: FaIcon(
                                          FontAwesomeIcons.shoppingBasket),
                                      color: Theme.of(context).primaryColor,
                                    );
                                  }
                                })
                          ],
                        ),
                        body: [
                          PrincipalTab(user: user),
                          SacolaTab(user: user),
                          PedidosTab(user: user),
                          PerfilTab(user: user),
                          admin! ? AdminTab() : null
                        ][selectedPage],
                        bottomNavigationBar: ConvexAppBar(
                            controller: _controller,
                            initialActiveIndex: 0,
                            onTap: (int i) {
                              setState(() {
                                selectedPage = i;
                              });
                              print('index= $i');
                            },
                            backgroundColor: Colors.grey[200],
                            elevation: 0,
                            color: Colors.black87,
                            items: admin ? adminTabs : userTabs),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ));
          }
        });
  }
}
