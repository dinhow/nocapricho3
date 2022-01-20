// import 'package:flutter/material.dart';
// import 'package:flutter_boom_menu/flutter_boom_menu.dart';

// class FabMenu extends StatelessWidget {
//   const FabMenu({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BoomMenu(
//         backgroundColor: Colors.blue,
//         animatedIcon: AnimatedIcons.menu_close,
//         animatedIconTheme: IconThemeData(size: 22.0),
//         child: Icon(Icons.add),
//         // onOpen: () => print('OPENING DIAL'),
//         // onClose: () => print('DIAL CLOSED'),
//         scrollVisible: true,
//         overlayColor: Colors.black,
//         overlayOpacity: 0.8,
//         children: [
//           MenuItem(
//             title: "Gerenciar Produtos",
//             titleColor: Colors.black,
//             subtitle: "Clique aqui para adicionar/editar produtos!",
//             subTitleColor: Colors.black,
//             backgroundColor: Colors.blue[100],
//             //onTap: () => Get.to(() => InputNewDataScreen())
//           ),
//           MenuItem(
//             title: "Gerenciar Categoria",
//             titleColor: Colors.black,
//             subtitle: "Para melhor organização, adicione/edite categorias!",
//             subTitleColor: Colors.black,
//             backgroundColor: Colors.redAccent[100],
//             //onTap: () => Get.to(() => AddCategoria())
//           ),
//           MenuItem(
//             title: "Gerenciar Clientes",
//             titleColor: Colors.grey[850],
//             subtitle: "Desabilite, Exclua e Edite dados dos clientes.",
//             subTitleColor: Colors.grey[850],
//             backgroundColor: Colors.pink[100],
//             //onTap: () => Get.to(() => InputNewDataScreen(category: 'fixa'))
//           ),
//           MenuItem(
//             title: "Configurações",
//             titleColor: Colors.black,
//             subtitle: "Altere as configurações gerais do aplicativo.",
//             subTitleColor: Colors.black,
//             backgroundColor: Colors.yellow[100],
//             //onTap: () => Get.to(() => InputNewDataScreen(category: 'divida'))
//           ),
//           MenuItem(
//             title: "Logout",
//             titleColor: Colors.black,
//             subtitle: "Para deslogar da sua conta, clique aqui!",
//             subTitleColor: Colors.black,
//             backgroundColor: Colors.blueGrey,
//             onTap: () {
//               //controller.signOut();
//             },
//           )
//         ]);
//   }
// }
