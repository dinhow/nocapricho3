import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:nocapricho3/models/user_model.dart';
import 'package:nocapricho3/widgets/categorias_listview.dart';
import 'package:nocapricho3/widgets/produtos_listview.dart';
import 'package:nocapricho3/widgets/search_produto.dart';

class PrincipalTab extends StatefulWidget {
  const PrincipalTab({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  _PrincipalTabState createState() => _PrincipalTabState();
}

class _PrincipalTabState extends State<PrincipalTab> {
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          pinned: false,
          snap: false,
          floating: false,
          expandedHeight: isEmpty == true
              ? MediaQuery.of(context).size.height * .40
              : MediaQuery.of(context).size.height * .11753,
          flexibleSpace: FlexibleSpaceBar(
              background: Container(
            padding: isEmpty == true
                ? EdgeInsets.only(top: 15, left: 15, right: 15)
                : EdgeInsets.only(left: 15, right: 15),
            color: Colors.grey[200],
            //height: MediaQuery.of(context).size.height * .4,
            width: MediaQuery.of(context).size.width,
            ////////////////////////////////////////////////////////////////////
            child: Column(
              children: [
                isEmpty == true
                    ? Padding(
                        padding: const EdgeInsets.only(left: 7.1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Olá, ${widget.user.name}!',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey[700])),
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(height: 12),
                // Container(
                //     width: MediaQuery.of(context).size.width, child: Search()),
                isEmpty == true
                    ? Container(height: 190, child: CategoriasListview())
                    : Container()
              ],
            ),
          )),
        ),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Cardápio',
                  style: TextStyle(
                      color: Colors.grey[700], fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text('A - Z', style: TextStyle(color: Colors.grey[700])),
                    FaIcon(
                      FontAwesomeIcons.arrowDown,
                      size: 10,
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              )
            ],
          ),
        )),
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          return ProdutosListview();
        }, childCount: 1)),
      ],
    );
  }
}
