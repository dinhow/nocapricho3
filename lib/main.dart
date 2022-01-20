import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nocapricho3/app.dart';
import 'package:nocapricho3/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: App(),
    ),
  );
}
