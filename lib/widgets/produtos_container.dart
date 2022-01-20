import 'package:nocapricho3/models/produto.dart';
import 'package:flutter/material.dart';

class ProdutosContainer extends StatelessWidget {
  final ProdutoModel? produto;

  const ProdutosContainer({Key? key, this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(produto!.nome);
    return Card(
      child: ListTile(
        //onTap: () => {Get.to(() => ProdutoPage(produto))},
        title: Text(produto!.nome.toString()),
        // subtitle: Text(produto!.descricao +
        //     '\nA PARTIR DE R\$' +
        //     produto!.valor.toStringAsPrecision(4)),
        isThreeLine: true,
        leading: Container(
          child: Image.network(produto!.img.toString()),
        ),
      ),
    );
  }
}
