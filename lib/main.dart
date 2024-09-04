import 'package:flutter/material.dart';
import 'package:wallpaperapplication/homepage.dart';
import 'package:wallpaperapplication/repository/customScrollBehaviour.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpr',
      debugShowCheckedModeBanner: false,
      // scrollBehavior: Customscrollbehaviour(),
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: Homepage(),
    );
  }
}
