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

class AdminTab extends StatefulWidget {
  const AdminTab({Key? key}) : super(key: key);

  @override
  _AdminTabState createState() => _AdminTabState();
}

class _AdminTabState extends State<AdminTab> {
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
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          myItems(Icons.list_alt, "Pedidos", 0xffed622b),
          myItems(Icons.person, "Clientes", 0xff26cb3c),
          GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ItemsPage())),
              child: myItems(Icons.category, "Itens", 0xffff3266)),
          // GestureDetector(
          //     onTap: () => Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => const AddProduto())),
          //     child: myItems(Icons.list, "Produtos", 0xff3399fe)),
          myItems(Icons.settings, "Configurações", 0xffed622b),
          myItems(Icons.notifications, "Notificações", 0xffed622b),
        ],
        staggeredTiles: [
          StaggeredTile.extent(1, 130),
          StaggeredTile.extent(1, 130),
          StaggeredTile.extent(2, 130),
          StaggeredTile.extent(1, 130),
          StaggeredTile.extent(1, 130),
          StaggeredTile.extent(1, 130),
        ],
      ),
    );
  }
}
