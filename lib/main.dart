import 'package:flutter/material.dart';

import 'widget/main_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Falutter',
      home: Scaffold(
        body: MainMenu(),
      ),
    );
  }

}