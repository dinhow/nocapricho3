import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:nocapricho3/models/categoria.dart';
import 'package:nocapricho3/models/produto.dart';
import 'package:nocapricho3/models/user_model.dart';
import 'package:nocapricho3/services/database_service.dart';
import 'package:nocapricho3/widgets/input_card.dart';
import 'package:profile_wheel/WheelItemConfig.dart';
import 'package:profile_wheel/profile_wheel.dart';

class PerfilTab extends StatefulWidget {
  const PerfilTab({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  _PerfilTabState createState() => _PerfilTabState();
}

class _PerfilTabState extends State<PerfilTab> {
  Map<String, double> tamanho = {"P": 9.9, "M": 10.9, "G": 12.9};

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              DatabaseService().addCategory(CategoriaModel(
                  id: 1,
                  img: 'img',
                  nome: 'Teste Categoria',
                  ativo: true,
                  dateCreated: DateTime.now()));
            },
            child: Text('Adicionar Categoria')),
        SizedBox(height: 15),
        ElevatedButton(
            onPressed: () {
              DatabaseService().addProduct(ProdutoModel(
                  id: 2,
                  img:
                      'https://cozinhandocomigo.files.wordpress.com/2012/06/receita-bisteca-porco-grelhada-molho-agridoce.jpg',
                  nome: 'Bisteca ao Molho Madeira',
                  categoria: 'Marmitas',
                  descricao: 'Arroz, Feijão e Bisteca ao Molho Madeira',
                  //valor: 9.9,
                  vezesComprado: 5,
                  tamanho: tamanho,
                  ativo: true,
                  dateCreated: DateTime.now()));
              // if (prod == null) {
              // prod!.nome = 'Bisteca ao Molho Madeira';
              // prod!.descricao = 'Arroz, Feijão e Bisteca ao Molho Madeira';
              // prod!.categoria = 'Marmitas';
              // prod!.img =
              //     'https://cozinhandocomigo.files.wordpress.com/2012/06/receita-bisteca-porco-grelhada-molho-agridoce.jpg';
              // prod?.valor = 10.9;
              // DatabaseService().addProduto(prod!);
              // }
            },
            child: Text('Adicionar Produto')),
        SizedBox(height: 15),
        Container(
            color: Colors.grey[200],
            height: 400,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(12),
            child: InputCard())
      ],
    )

        // Text(
        //   'EM BREVE',
        //   style: TextStyle(
        //       fontWeight: FontWeight.bold, fontSize: 40, color: Colors.grey[700]),
        // ),

        );

    // Scaffold(
    //   body: Container(
    //     width: MediaQuery.of(context).size.width,
    //     height: MediaQuery.of(context).size.height,
    //     color: Colors.grey[200],
    //     child: Column(
    //       children: [
    //         Expanded(
    //           child: Container(
    //             child: ProfileWheel(
    //               itemConfig: WheelItemConfig(
    //                 icon1: FontAwesomeIcons.coins,
    //                 onTapCallback1: () {},
    //                 shadowOffset1: Offset(-2, -2),
    //                 title1: "123 Pontos",
    //                 icon2: FontAwesomeIcons.bell,
    //                 onTapCallback2: () {},
    //                 shadowOffset2: Offset(2, -2),
    //                 title2: "0 Notificações",
    //                 icon3: FontAwesomeIcons.list,
    //                 onTapCallback3: () {
    //                   print('Posts');
    //                 },
    //                 shadowOffset3: Offset(-4, 8),
    //                 title3: "7 Pedidos",
    //                 icon4: Icons.more,
    //                 onTapCallback4: () {
    //                   print('Badges');
    //                 },
    //                 shadowOffset4: Offset(4, 8),
    //                 title4: "Outros",
    //               ),
    //               dividerColor: Colors.black,
    //               backgroundColor: Colors.grey[200],
    //               dividerWeight: 1,
    //               preSelected: selected,
    //               imageProvider: NetworkImage(
    //                   "https://www.w3schools.com/howto/img_avatar2.png"),
    //               width: MediaQuery.of(context).size.width * .9,
    //               imageSize: 100,
    //             ),
    //           ),
    //         ),
    //         Expanded(
    //             child: Container(
    //           child: ListView(),
    //         ))
    //       ],
    //     ),
    //   ),
    // );
  }
}
