import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:nocapricho3/models/categoria.dart';
import 'package:nocapricho3/models/produto.dart';
import 'package:nocapricho3/pages/add_categoria.dart';
import 'package:nocapricho3/pages/add_produto.dart';
import 'package:nocapricho3/pages/items_page.dart';
import 'package:nocapricho3/services/database_service.dart';
import 'package:nocapricho3/widgets/input_card.dart';

class FabItemsMenu extends StatefulWidget {
  const FabItemsMenu({Key? key}) : super(key: key);

  @override
  _FabItemsMenuState createState() => _FabItemsMenuState();
}

class _FabItemsMenuState extends State<FabItemsMenu> {
  Material myItems(IconData icon, String heading, int color) {
    return Material(
      color: Colors.white,
      elevation: 14,
      shadowColor: Color(0x802196F3),
      borderRadius: BorderRadius.circular(24),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                //text
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(heading,
                      style: TextStyle(color: new Color(color), fontSize: 20)),
                ),
                //icon
                Material(
                  color: new Color(color),
                  borderRadius: BorderRadius.circular(24),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar itens'),
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddCategoria())),
              child:
                  myItems(Icons.category, "Adicionar Categoria", 0xffff3266)),
          GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddProduto(
                            categoria: '',
                          ))),
              child: myItems(
                  Icons.shopping_basket, "Adicionar Produto", 0xff3399fe)),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 130),
          StaggeredTile.extent(2, 130),
        ],
      ),
    );
  }
}
