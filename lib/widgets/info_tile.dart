import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  final info;
  final Color? color;
  final String? observacao;

  const InfoTile({Key? key, this.info, this.color, this.observacao})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image(image: NetworkImage(info.img)),
      title: Text(info.nome),
      subtitle: Text(info.descricao),
      isThreeLine: true,
      trailing: Text(info.ativo.toString()),
    );
  }
}
