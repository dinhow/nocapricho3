import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nocapricho3/services/auth_service.dart';
import 'package:nocapricho3/services/database_service.dart';

class ProductRow extends StatelessWidget {
  const ProductRow({Key? key, required this.product}) : super(key: key);
  final DocumentSnapshot product;

  @override
  Widget build(BuildContext context) {
    final formatCurrency =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'R\$');
    int quantity = 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${quantity.toString()}' + 'x ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(child: Text(product["nome"])),
        Text('${formatCurrency.format(product["valor"])}'),
        IconButton(
            onPressed: () {
              DatabaseService()
                  .removeItemBag(product["id"], AuthService().currentUser());
            },
            icon: FaIcon(
              FontAwesomeIcons.ellipsisV,
              size: 15,
            ))
      ],
    );
  }
}
