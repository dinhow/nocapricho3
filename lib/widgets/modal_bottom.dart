import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class ModalBottom extends StatefulWidget {
  const ModalBottom({Key? key}) : super(key: key);

  @override
  _ModalBottomState createState() => _ModalBottomState();
}

class _ModalBottomState extends State<ModalBottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Column(
        children: [
          Center(
            child: Container(
              width: 150,
              height: 25,
              child: Divider(
                thickness: 5,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Column(
              children: [
                Row(children: [
                  Text('Endereço da entrega',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                ]),
                SizedBox(height: 12),
                GestureDetector(
                  child: Container(
                    //color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    child: ListTile(
                      leading: FaIcon(FontAwesomeIcons.searchLocation,
                          color: Colors.black87),
                      title: Text(
                        'Usar minha localização atual',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: ListTile(
                    isThreeLine: true,
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.home,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                      ],
                    ),
                    title: Text('Casa',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        'Rua Uirapuru, 274 - Vila Gilcy, Colombo - PR\nCasa 1, Frente'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.ellipsisV,
                            color: Colors.redAccent, size: 20),
                      ],
                    ),
                  ),
                )),
                SizedBox(height: 10),
                GestureDetector(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: ListTile(
                    isThreeLine: true,
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.home,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                      ],
                    ),
                    title: Text('Trabalho',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        'Av. Iguaçu, 2740 - Água Verde, Curitiba - PR\nSegundo andar'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.ellipsisV,
                            color: Colors.redAccent, size: 20),
                      ],
                    ),
                  ),
                )),
                SizedBox(height: 10),
                GestureDetector(
                    child: Container(
                  //color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: ListTile(
                    leading: FaIcon(FontAwesomeIcons.locationArrow,
                        color: Colors.black87),
                    title: Text(
                      'Adicionar novo endereço',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
