import 'package:flutter/material.dart';
import 'package:healthcare/Screens/Maps/tracking_screen.dart';
import 'package:flutter/services.dart';

//File Start Pertama kali, Pemanggilan Tracking_screen.dart
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      title: "Health App",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Screen(),
    );
  }
}
