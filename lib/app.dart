import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocapricho3/widgets/auth_check.dart';
import 'package:flutter/services.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'No Capricho',
      theme: ThemeData(primaryColor: Colors.redAccent),
      home: AuthCheck(),
    );
  }
}
