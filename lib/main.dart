import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness:
        Brightness.dark, // this will change the brightness of the icons
    statusBarColor: Colors.blue, // or any color you want
  ));
  await Firebase.initializeApp();

  runApp(const App());
}
