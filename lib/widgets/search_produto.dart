import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final TextEditingController? textController = TextEditingController();

  Search({Key? key, TextEditingController? textController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .92,
          child: Stack(
            children: [
              Positioned(
                  left: 60,
                  bottom: 42,
                  child: Text('Pesquisar no cardápio',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700]))),
              AnimSearchBar(
                width: MediaQuery.of(context).size.width,
                textController: textController!,
                onSuffixTap: () {
                  textController!.clear();
                },
                helpText: 'Pesquisar...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
