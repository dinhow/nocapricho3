import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PreviewPage extends StatelessWidget {
  PreviewPage({Key? key, required this.file}) : super(key: key);
  File file;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
                child: Stack(
              children: [
                Positioned.fill(
                    child: Image.file(
                  file,
                  fit: BoxFit.cover,
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.black.withOpacity(.5),
                          child: IconButton(
                              onPressed: () => Get.back(result: file),
                              icon: FaIcon(
                                FontAwesomeIcons.check,
                                color: Colors.white,
                                size: 30,
                              )),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.black.withOpacity(.5),
                          child: IconButton(
                              onPressed: () => Get.back(),
                              icon: FaIcon(
                                FontAwesomeIcons.times,
                                color: Colors.white,
                                size: 30,
                              )),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
